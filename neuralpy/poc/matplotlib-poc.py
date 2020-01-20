# -*- coding: utf-8 -*-
'''
Matplotlib
'''

#from __future__ import division
import numpy as np
import matplotlib.pyplot as plt
from math import pi

# Contour plot
# x = np.arange(-5, 5, 0.1)
# y = np.arange(-5, 5, 0.1)
# xx, yy = np.meshgrid(x, y, sparse=True)
# z = np.sin(xx**2 + yy**2) / (xx**2 + yy**2)
# h = plt.contourf(x,y,z)
# plt.show()



fig,ax = plt.subplots()
f = 1.0 # Hz, signal frequency
fs = 5.0 # Hz, sampling rate (ie. >= 2*f)
t = np.arange(-1,1+1/fs,1/fs) # sample interval, symmetric
# for convenience later
x = np.sin(2*pi*f*t)
ax.plot(t,x,"o-")
ax.set_xlabel("Time",fontsize=18)
ax.set_ylabel("Amplitude",fontsize=18)

