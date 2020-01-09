import numpy as np

x = np.array([1,1,1],dtype=np.float32)
x.itemsize
np.sin(x)

y = np.array([ [1,2,3],[4,5,6] ])
y[:,0] # 0th
y[:,1] # 1st
y[0,:] # 0th
y[1,:] # 1st

y.shape
y[:,1:] # all rows, 1st thru last column
y[:,::2] # all rows, every other column

x = np.ones((3,3))
x
x[:,[0,1,2,2]] # notice duplicated last dimension
y=x[:,[0,1,2,2]] # same as above, but do assign it
x[0,0]=999

# Listing 1.9: As a consequence of the pass-by-reference semantics, Numpy views point at the
# same memory as their parents, so changing an element in x updates the corresponding element
# in y. This is because a view is just a window into the same memory.
x = np.ones((3,3))
y = x[:2,:2] # upper left piece

X,Y=np.meshgrid(np.arange(2),np.arange(2))
z = np.linspace(0, 1, 10)

np.linspace(1,10)
np.arange(1,10)
np.range(3)