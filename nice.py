

'''
var = raw_input("Enter something: ")
print "you entered ", var
'''

a={'John':'Naughty','Clara':'Nice'}
for name, status in a.iteritems():
    if (status == 'Nice'):
	print name , ": ", status
