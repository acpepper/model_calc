from setuptools import setup
from Cython.Build import cythonize



setup(
    ext_modules = cythonize(["model_calc.pyx",
                             "mesh.pyx",
                             "plot_mesh.pyx"])
)
