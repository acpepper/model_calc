import matplotlib.pyplot as plt
import matplotlib.tri as mtri

from mesh import *



def plotCube(ax, pos):
    '''
    Test: plot cube using Axes3D.plot_trisurf()
    '''
    print("Hi")
    
def plotBlocks(mesh):
    fig, ax = plt.subplot()
    
    X = [0, 1, 0, 0, 1, 0, 1, 1]
    Y = [0, 0, 1, 0, 1, 1, 0, 1]
    Z = [0, 0, 0, 1, 0, 1, 1, 1]
    ax.plot_trisurf(X, Y, Z)

    plt.savefig("./boxes.png")
    
