# imagecodecs/zlib_ng.pxd
# cython: language_level = 3

# Cython declarations for the `zlib-ng 2.0.5` library.
# https://github.com/zlib-ng/zlib-ng

from libc.stdint cimport int32_t, uint8_t, uint32_t

cdef extern from 'zlib-ng.h':

    char* ZLIBNG_VERSION
    int ZLIBNG_VERNUM
    int ZLIBNG_VER_MAJOR
    int ZLIBNG_VER_MINOR
    int ZLIBNG_VER_REVISION
    int ZLIBNG_VER_SUBREVISION

    ctypedef int z_off_t
    ctypedef int z_off64_t

    ctypedef void* (*alloc_func) (
        void* opaque,
        unsigned int items,
        unsigned int size
    ) nogil

    ctypedef void (*free_func) (
        void* opaque,
        void* address
    ) nogil

    ctypedef struct internal_state:
        pass

    ctypedef struct zng_stream:
        const uint8_t* next_in
        uint32_t avail_in
        size_t total_in
        uint8_t* next_out
        uint32_t avail_out
        size_t total_out
        const char* msg
        internal_state* state
        alloc_func zalloc
        free_func zfree
        void* opaque
        int data_type
        uint32_t adler
        unsigned long reserved

    ctypedef zng_stream* zng_streamp

    ctypedef struct zng_gz_header:
        int32_t text
        unsigned long time
        int32_t xflags
        int32_t os
        uint8_t* extra
        uint32_t extra_len
        uint32_t extra_max
        uint8_t* name
        uint32_t name_max
        uint8_t* comment
        uint32_t comm_max
        int32_t hcrc
        int32_t done

    ctypedef zng_gz_header* zng_gz_headerp

    int Z_NO_FLUSH
    int Z_PARTIAL_FLUSH
    int Z_SYNC_FLUSH
    int Z_FULL_FLUSH
    int Z_FINISH
    int Z_BLOCK
    int Z_TREES

    # return codes
    int Z_OK
    int Z_STREAM_END
    int Z_NEED_DICT
    int Z_ERRNO
    int Z_STREAM_ERROR
    int Z_DATA_ERROR
    int Z_MEM_ERROR
    int Z_BUF_ERROR
    int Z_VERSION_ERROR

    # compression levels
    int Z_NO_COMPRESSION
    int Z_BEST_SPEED
    int Z_BEST_COMPRESSION
    int Z_DEFAULT_COMPRESSION

    # compression strategy
    int Z_FILTERED
    int Z_HUFFMAN_ONLY
    int Z_RLE
    int Z_FIXED
    int Z_DEFAULT_STRATEGY

    # data_type
    int Z_BINARY
    int Z_TEXT
    int Z_ASCII
    int Z_UNKNOWN

    int Z_DEFLATED
    int Z_NULL

    # basic functions

    # const char* zlibng_version() nogil

    int zng_deflateInit(
        zng_stream* strm,
        int level
    ) nogil

    int32_t zng_deflate(
        zng_stream* strm,
        int32_t flush
    ) nogil

    int32_t zng_deflateEnd(
        zng_stream* strm
    ) nogil

    int zng_inflateInit(
        zng_stream* strm
    ) nogil

    int32_t zng_inflate(
        zng_stream* strm,
        int32_t flush
    ) nogil

    int32_t zng_inflateEnd(
        zng_stream* strm
    ) nogil

    # advanced function

    int zng_deflateInit2(
        zng_stream* strm,
        int level,
        int method,
        int windowBits,
        int memLevel,
        int strategy
    ) nogil

    int32_t zng_deflateSetDictionary(
        zng_stream* strm,
        const uint8_t* dictionary,
        uint32_t dictLength
    ) nogil

    int32_t zng_deflateGetDictionary(
        zng_stream* strm,
        uint8_t* dictionary,
        uint32_t* dictLength
    ) nogil

    int32_t zng_deflateCopy(
        zng_stream* dest,
        zng_stream* source
    ) nogil

    int32_t zng_deflateReset(
        zng_stream* strm
    ) nogil

    int32_t zng_deflateParams(
        zng_stream* strm,
        int32_t level,
        int32_t strategy
    ) nogil

    int32_t zng_deflateTune(
        zng_stream* strm,
        int32_t good_length,
        int32_t max_lazy,
        int32_t nice_length,
        int32_t max_chain
    ) nogil

    unsigned long zng_deflateBound(
        zng_stream* strm,
        unsigned long sourceLen
    ) nogil

    int32_t zng_deflatePending(
        zng_stream* strm,
        uint32_t* pending,
        int32_t* bits
    ) nogil

    int32_t zng_deflatePrime(
        zng_stream* strm,
        int32_t bits,
        int32_t value
    ) nogil

    int32_t zng_deflateSetHeader(
        zng_stream* strm,
        zng_gz_headerp head
    ) nogil

    int zng_inflateInit2(
        zng_stream* strm,
        int windowBits
    ) nogil

    int32_t zng_inflateSetDictionary(
        zng_stream* strm,
        const uint8_t* dictionary,
        uint32_t dictLength
    ) nogil

    int32_t zng_inflateGetDictionary(
        zng_stream* strm,
        uint8_t* dictionary,
        uint32_t* dictLength
    ) nogil

    int32_t zng_inflateSync(
        zng_stream* strm
    ) nogil

    int32_t zng_inflateCopy(
        zng_stream* dest,
        zng_stream* source
    ) nogil

    int32_t zng_inflateReset(
        zng_stream* strm
    ) nogil

    int32_t zng_inflateReset2(
        zng_stream* strm,
        int32_t windowBits
    ) nogil

    int32_t zng_inflatePrime(
        zng_stream* strm,
        int32_t bits,
        int32_t value
    ) nogil

    long zng_inflateMark(
        zng_stream* strm
    ) nogil

    int32_t zng_inflateGetHeader(
        zng_stream* strm,
        zng_gz_headerp head
    ) nogil

    int zng_inflateBackInit(
        zng_stream* strm,
        int windowBits,
        unsigned char* window
    ) nogil

    ctypedef uint32_t (*in_func) (
        void*,
        const uint8_t**
    ) nogil

    ctypedef int32_t (*out_func) (
        void*,
        uint8_t*,
        uint32_t
    ) nogil

    int32_t zng_inflateBack(
        zng_stream* strm,
        in_func infunc,
        void* in_desc,
        out_func out,
        void* out_desc
    ) nogil

    int32_t zng_inflateBackEnd(
        zng_stream* strm
    ) nogil

    unsigned long zng_zlibCompileFlags() nogil

    # utility functions

    int32_t zng_compress(
        uint8_t* dest,
        size_t* destLen,
        const uint8_t* source,
        size_t sourceLen
    ) nogil

    int32_t zng_compress2(
        uint8_t* dest,
        size_t* destLen,
        const uint8_t* source,
        size_t sourceLen,
        int32_t level
    ) nogil

    size_t zng_compressBound(
        size_t sourceLen
    ) nogil

    int32_t zng_uncompress(
        uint8_t* dest,
        size_t* destLen,
        const uint8_t* source,
        size_t sourceLen
    ) nogil

    int32_t zng_uncompress2(
        uint8_t* dest,
        size_t* destLen,
        const uint8_t* source,
        size_t* sourceLen
    ) nogil

    # gzip file access functions

    ctypedef struct gzFile_s:
        pass

    ctypedef gzFile_s* gzFile

    gzFile zng_gzopen(
        const char* path,
        const char* mode
    ) nogil

    gzFile zng_gzdopen(
        int fd,
        const char* mode
    ) nogil

    int32_t zng_gzbuffer(
        gzFile file,
        uint32_t size
    ) nogil

    int32_t zng_gzsetparams(
        gzFile file,
        uint32_t level,
        int32_t strategy
    ) nogil

    int32_t zng_gzread(
        gzFile file,
        void* buf,
        uint32_t len
    ) nogil

    size_t zng_gzfread(
        void* buf,
        size_t size,
        size_t nitems,
        gzFile file
    ) nogil

    int32_t zng_gzwrite(
        gzFile file,
        const void* buf,
        uint32_t len
    ) nogil

    size_t zng_gzfwrite(
        const void* buf,
        size_t size,
        size_t nitems,
        gzFile file
    ) nogil

    int32_t zng_gzprintf(
        gzFile file,
        const char* format,
        ...
    ) nogil

    int32_t zng_gzputs(
        gzFile file,
        const char* s
    ) nogil

    char*  zng_gzgets(
        gzFile file,
        char* buf,
        int32_t len
    ) nogil

    int32_t zng_gzputc(
        gzFile file,
        int32_t c
    ) nogil

    int32_t zng_gzgetc(
        gzFile file
    ) nogil

    int32_t zng_gzungetc(
        int32_t c,
        gzFile file
    ) nogil

    int32_t zng_gzflush(
        gzFile file,
        int32_t flush
    ) nogil

    z_off64_t zng_gzseek(
        gzFile file,
        z_off64_t offset,
        int whence
    ) nogil

    int32_t zng_gzrewind(
        gzFile file
    ) nogil

    z_off64_t zng_gztell(
        gzFile file
    ) nogil

    z_off64_t zng_gzoffset(
        gzFile file
    ) nogil

    int32_t zng_gzeof(
        gzFile file
    ) nogil

    int32_t zng_gzdirect(
        gzFile file
    ) nogil

    int32_t zng_gzclose(
        gzFile file
    ) nogil

    int32_t zng_gzclose_r(
        gzFile file
    ) nogil

    int32_t zng_gzclose_w(
        gzFile file
    ) nogil

    const char*  zng_gzerror(
        gzFile file,
        int32_t* errnum
    ) nogil

    void zng_gzclearerr(
        gzFile file
    ) nogil

    # checksum functions

    uint32_t zng_adler32(
        uint32_t adler,
        const uint8_t* buf,
        uint32_t len
    ) nogil

    uint32_t zng_adler32_z(
        uint32_t adler,
        const uint8_t* buf,
        size_t len
    ) nogil

    uint32_t zng_adler32_combine(
        uint32_t adler1,
        uint32_t adler2,
        z_off64_t len2
    ) nogil

    uint32_t zng_crc32(
        uint32_t crc,
        const uint8_t* buf,
        uint32_t len
    ) nogil

    uint32_t zng_crc32_z(
        uint32_t crc,
        const uint8_t* buf,
        size_t len
    ) nogil

    uint32_t zng_crc32_combine(
        uint32_t crc1,
        uint32_t crc2,
        z_off64_t len2
    ) nogil

    void zng_crc32_combine_gen(
        uint32_t op[32],
        z_off64_t len2
    ) nogil

    uint32_t zng_crc32_combine_op(
        uint32_t crc1,
        uint32_t crc2,
        const uint32_t* op
    ) nogil
