.. _change_sparse_backend:

======================
Sparse matrix backends
======================

As the BIOM project evolves, so do the underlying data structures, leading to potential runtime trade offs between implementations. Currently, there are three distinct sparse matrix backends to BIOM: the ``CSMat`` (default as of BIOM v1.1), the ``SparseMat`` and the ``SparseDict``. Specific differences are discussed below.

How to check what sparse backend is in use
==========================================

To check what sparse backend is in use, simply execute ``biom show-install-info``. The last line shows the SparseObj type. For instance::

 $ biom show-install-info

 System information
 ==================
           Platform:	darwin
 Python/GCC version:	2.7.1 (r271:86832, Aug 30 2012, 10:07:33)  [GCC 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2336.11.00)]
  Python executable:	/Users/caporaso/.virtualenvs/biom/bin/python
 
 Dependency versions
 ===================
     pyqi version:	0.2.0
    NumPy version:	1.7.1
 dateutil version:	1.5
 
 biom-format package information
 ===============================
 biom-format version:	1.2.0
      SparseObj type:	biom.csmat.CSMat

The last line indicates that the ``CSMat`` object is in use.

Changing the sparse backend
===========================

There are two methods to change the backend that is used. The first method is by copying the ``biom_config`` file located under ``support_files/`` and placing it in your home directory as ``~/.biom_config``. Then, edit ``~/.biom_config`` and replace the current backend type with the desired type.

The second method is to set the environment variable ``$BIOM_CONFIG_FP`` to a file path of your choice, and place the following into that file::

	python_code_sparse_backend	<BACKEND TYPE>

Where ``<BACKEND TYPE>`` is replaced by the specific backend implementation to use.

Sparse matrix backend descriptions
==================================

Different sparse matrix backends have different performance characteristics. As BIOM changes over time, additional methods may be added that address specific runtime concerns.

CSMat
-----

The default sparse backend is the ``CSMat``. ``CSMat`` implements coordinate list, compressed sparse row and compressed sparse column formats and facilitates interaction with these representations. This backend will have the lowest memory footprint. In general, this backend should be the fastest. However, it has been observed that under certain circumstances, this backend may not perform the best.

SparseMat
---------

The ``SparseMat`` is built using a combination of Python objects, a Cython wrapper and C++. It implements the dictionary of keys sparse matrix representation. This method performs pretty well, but has an increasing memory footprint as the number of nonzero values increases. Under some situations, specifically those that require a large number of ``Table`` creations, this backend has about a 15-20% reduced runtime over ``CSMat``.

SparseDict
----------

The ``SparseDict`` is the naive pure Python implementation. This was first implemented as a test backend, and it is not advised to use this object.
