#  Simple Python OpenSCAD Code Generator
#  Copyright (C) 2009  Philipp Tiefenbacher <wizards23@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  http://www.gnu.org/licenses/gpl.html


class openscad_object:
  def __init__(self, name, params):
    self.name = name
    self.params = params
    self.children = []
    self.modifier = ""

  def setModifier(self, m):
    self.modifier = m
    return self

  def render(self):
    s = "\n" + self.modifier + self.name + "("
    first = True
    
    #validKeys = filter(lambda x: self.params[x] != None, self.params.keys())
    #print(validKeys)
    #exit()
    validKeys = self.params.keys()
    # intkeys are the positional parameters
    intkeys = filter(lambda x: type(x)==int, validKeys)
    intkeys.sort()
    # named parameters
    nonintkeys = filter(lambda x: not type(x)==int, validKeys)
    
    for k in intkeys+nonintkeys:
      v = self.params[k]
      if v == None:
        continue

      if not first:      
        s += ", "
      first = False

      if type(k)==int:
        s += py2openscad(v)
      else:
        s += k + " = " + py2openscad(v)
    s += ")"
    if self.children != None and len(self.children) > 0:
      s += " {"
      for child in self.children:
        s += indent(child.render())
      s += "\n}"
    else:
      s += ";"
    return s

  def add(self, child):
    self.children.append(child)
    return self

  def addParam(self, k, v):
    self.params[k] = v
    return self

def py2openscad(o):
  if type(o) == bool:
    return str(o).lower()
  if type(o) == float:    
    return "%.10f" % o
  if type(o) == list:
    s = "["
    first = True
    for i in o:
      if not first:
        s +=  ", "
      first = False
      s += py2openscad(i)
    s += "]"
    return s
  if type(o) == str:
    return '"' + o + '"'
  return str(o)

def indent(s):
  return s.replace("\n", "\n\t")

class union(openscad_object):
  def __init__(self):
    openscad_object.__init__(self, 'union', {})

class intersection(openscad_object):
  def __init__(self):
    openscad_object.__init__(self, 'intersection', {})

class difference(openscad_object):
  def __init__(self):
    openscad_object.__init__(self, 'difference', {})

class sphere(openscad_object):
  def __init__(self, r=1):
    openscad_object.__init__(self, 'sphere', {'r':r})

class cube(openscad_object):
  def __init__(self, size=1, center=False):
    openscad_object.__init__(self, 'cube', {'size':size, 'center':center})

class cylinder(openscad_object):
  def __init__(self, r=1, h=1):
    openscad_object.__init__(self, 'cylinder', {'r':r, 'h':h})

class translate(openscad_object):
  def __init__(self, v=[0,0,0]):
    openscad_object.__init__(self, 'translate', {1:v})

class scale(openscad_object):
  def __init__(self, s=[0,0,0]):
    openscad_object.__init__(self, 'scale', {1:s})

class rotate(openscad_object):
  def __init__(self, a, v=None):
    openscad_object.__init__(self, 'rotate', {'a':a, 'v':v})

class dxf_linear_extrude(openscad_object):
  def __init__(self, file="", layer=1, height=1, center=False, convexity=5, twist=0, slices=None):
    openscad_object.__init__(self, 'dxf_linear_extrude', {'file':file, 'layer':layer, 'height':height, 'center':center, 'convexity':convexity, 'twist':twist, 'slices':slices})

class polyhedron(openscad_object):
  def __init__(self, points, triangles, convexity):
    openscad_object.__init__(self, 'polyhedron', {'points':points, 'triangles':triangles, 'convexity':convexity})



