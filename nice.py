
a={'John':'Naughty','Clara':'Nice'}
for name, status in a.iteritems():
    if (status == 'Nice'):
	print name + ": "+ status
