from xml.dom.minidom import parse

# this is written for Python 2 and I run it under Python 2.7.2
# It shouldn't be difficult to rewrite this example to run under Python 3 if you wanted to

t = parse("example.hwml")

def getText(nodelist):
    rc = []
    for node in nodelist:
        if node.nodeType == node.TEXT_NODE:
            rc.append(node.data)
    return ''.join(rc)

def attributesOf(aNode):
	def helper():
		attrs = aNode.attributes
		l = attrs.length
		for i in range(l):
			attr = attrs.item(i)
			yield (str(attr.localName),attr.value)
	return dict(helper())

assignments = t.getElementsByTagName("assignment")


for assignment in assignments:
	attrs = attributesOf(assignment)
	print attrs["student"]+" used book edition "+attrs["book_edition"]+" to do the assignment for chapter "+attrs["chapter"]
	problems = assignment.getElementsByTagName("problem")
	for problem in problems:
		attrs = attributesOf(problem)
		print attrs["number"]
		print getText(problem.childNodes)



