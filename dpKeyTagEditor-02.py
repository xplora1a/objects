# dpKeyTagEditor-02
""" Graphical editor for 3D Keytags
David Price, April 2016
This editor allows text to be defined for a keytag.
Once accepted the keytag can be converted and saved as a SCAD file.
The SCAD file can be opened in OpenSCAD to render a 3D model
"""

import os, sys, re
import subprocess
from solid import *
from solid.utils import *
from PyQt4.QtCore import *
from PyQt4.QtGui import *

#create main window class as subclass of QWidget
# this will be a container for the other objects
class Window(QWidget):

    def __init__(self, parent = None):

        QWidget.__init__(self, parent)      # invoke superclass's initialiser

        # define some instance variables
        self.text = "3D Printing"
        self.fontsize = 18
        self.font = QFont()

        # tag geometry
        self.ring = 25    # the ring diameter
        self.hole = 12       # the hole diameter
        self.textsize = 10
        self.thickness = 3  # tag thickness
        self.taglength = 60 # length of rectangular section of tag
        self.tagwidth = 20  # width of rectangular section of tag
        self.baseline = 0   # offset from bottom edge to text baseline
        self.textstart = 2  # offset from left edge to text start
        self.textheight = 2 # depth of text relief
        self.bounds = QRectF()

        # create the main graphical view
        self.view = QGraphicsView()

        # create labels and control widgets
        textLabel = QLabel("&Text:")
        lineEdit = QLineEdit(self.text)
        textLabel.setBuddy(lineEdit)        # associate label

        fontSizeLabel = QLabel("&Size:")
        spinBox = QSpinBox()
        spinBox.setMinimum(1)
        spinBox.setValue(self.fontsize)
        fontSizeLabel.setBuddy(spinBox)     # associate label

        fontLabel = QLabel("&Font:")
        fontCombo = QFontComboBox()
        fontLabel.setBuddy(fontCombo)       # associate label

        makeButton = QPushButton("&Make it")

        # associate slots with event signals
        self.connect(lineEdit, SIGNAL("textChanged(const QString &)"),
                     self.setText)
        self.connect(spinBox, SIGNAL("valueChanged(int)"), self.setFontSize)
        self.connect(fontCombo, SIGNAL("currentFontChanged(const QFont &)"),
             self.setFont)
        self.connect(makeButton, SIGNAL("clicked(bool)"), self.makeit)

        # sub-layout for controls
        controlsLayout = QGridLayout()
        controlsLayout.addWidget(textLabel, 0, 0)   # row 0, column 0
        controlsLayout.addWidget(lineEdit, 0, 1)    # row 0, column 1
        controlsLayout.addWidget(fontLabel, 1, 0)
        controlsLayout.addWidget(fontCombo, 1, 1)
        controlsLayout.addWidget(fontSizeLabel, 2, 0)
        controlsLayout.addWidget(spinBox, 2, 1)

        controlsLayout.addWidget(makeButton,3,1)

        controlsLayout.setRowStretch(3, 1)          # stretch row 3 by factor of 1

        # layout with graphical view
        layout = QVBoxLayout()
        layout.addWidget(self.view, 1)
        layout.addLayout(controlsLayout)
        self.setLayout(layout)

        self.createScene()
        self.setWindowTitle("3D Keytag Editor")

    # render graphical scene on any changes
    def createScene(self):
        scene = QGraphicsScene()
        self.view.setScene(scene)

        self.font.setPointSize(self.fontsize)

        fontMetrics = QFontMetricsF(self.font)
        textheight = fontMetrics.height()

        textitem = scene.addText(self.text, self.font)
        textitem.translate(20, 20)

        self.scene = scene
        self.view.update()
        print("family: " + self.font.family())
        print("Freetype: " + self.font.styleName())
        print("height " + str(textheight))
        self.bounds = textitem.boundingRect()
        print("bounds " + str(self.bounds))

    # process events
    def setFontSize(self, number):
        self.fontsize = number
        self.createScene()

    def setText(self, text):
        self.text = QString(text)
        self.createScene()

    def setFont(self, font):
        self.font = QFont(font)
        self.createScene()

    def makeit(self, bool):
        print("make the tag")

        string = str(self.text)
        usefont = str(self.font.family())
        textsize = self.textsize
#        taglength = self.taglength
        taglength = 1.2 * self.bounds.width()/2
        print("length is " + str(taglength))
        baseline = self.baseline
        textstart = self.textstart
        textheight = self.textheight
        thickness = self.thickness

        out_dir = sys.argv[1] if len(sys.argv) > 1 else os.curdir

        print("file will be " + self.text + ".scad")
        file_out = os.path.join(out_dir, str(self.text) + ".scad")


        a1 = translate([textstart, baseline, -textheight])(text(text=string, font=usefont, size=textsize))
        a = linear_extrude(height=textheight + 0.1, center=True)(a1)

        b = translate([-2, -5, -thickness])(cube([taglength, 20, thickness]))
        c = translate([0, 5, -thickness])(cylinder(h=thickness, r=self.ring/2))
        d = translate([-3, 5, -thickness - 0.1])(cylinder(h=thickness + 0.2, r=self.hole/2))
        final = (b + (c - d)) - a

        scad_render_to_file(final, file_out, include_orig_code=False)


# main entry point
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = Window()
    window.show()
    sys.exit(app.exec_())
