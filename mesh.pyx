import numpy as np



class Cell:
    def __init__(self, **kwargs):
        try:
            self.pos = kwargs["pos"]
        except:
            self.pos = np.zeros(3, dtype=float)

        try:
            self.parent = kwargs["parent"]
        except:
            self.parent = None


            
class Block:
    def __init__(self, **kwargs):
        try:
            self.pos = kwargs["pos"]
        except:
            self.pos = np.zeros(3, dtype=float)
        
        try:
            self.depth = kwargs["depth"]
        except:
            self.depth = 0

        try:
            self.children = kwargs["children"]
        except:
            self.children = None
            
        try:
            self.isLeaf = kwargs["isLeaf"]
        except:
            self.isLeaf = None

        try:
            self.cell = kwargs["cell"]
        except:
            self.cell = None
            
    def getOctant(self, pos):
        '''
        returns a tuple representing the octant of the parent block which 
        contains 'pos'. 
        e.g. for a cell encompacing the unit cube, the point (0.25, 0.25, 0.25)
        would return (0, 0, 0), while the point (0.75, 0.75, 0.75) would return
        (1, 1, 1)
        '''
        if self.isLeaf:
            return None
        elif pos[0] <= self.pos[0]:
            if pos[1] <= self.pos[1]:
                if pos[2] <= self.pos[2]:
                    return (0, 0, 0)
                else:
                    return (0, 0, 1)
            else:
                if pos[2] <= self.pos[2]:
                    return (0, 1, 0)
                else:
                    return (0, 1, 1)
        else:
            if pos[1] <= self.pos[1]:
                if pos[2] <= self.pos[2]:
                    return (1, 0, 0)
                else:
                    return (1, 0, 1)
            else:
                if pos[2] <= self.pos[2]:
                    return (1, 1, 0)
                else:
                    return (1, 1, 1)
            
    def addBlock(self, newLeaf):
        '''
        'newLeaf' is a Cell
        '''
        if self.isLeaf:
            # create new block array
            self.children = np.empty((2, 2, 2), dtype=Block)
        else:
            pntr = self.children(self.getOctant(newLeaf.pos))
            while not pntr.isLeaf:
                pntr = pntr.children(pntr.getOctant(newLeaf.pos))

            # create new block array
            self.children = np.empty((2, 2, 2), dtype=Block)
    

        
class Mesh:
    def __init__(self, initCond):
        # create BH tree
        self.blocks = np.empty(initCond.blocks, dtype=Block)
        
        # initialization
        for pp in initCond.pointParticles:
            # find block
            block = self.blocks[0]
            block.insertPP(pp, self.maxDepth)

    def getCell(self, pos):
        for block in self.blocks:
            pntr = block
            while not pntr.isLeaf:
                pntr = pntr.children(pntr.getOctant(pos))

        return pntr.cell

    def insertPP(self, pp, maxDepth):
        '''PP is for point particle'''
        depth = 0
