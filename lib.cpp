#include <bits/stdc++.h>
using namespace std;

// using str = pair<const char*, size_t>;

// struct PyObject{
//     size_t count = 1;
//     unordered_map<string_view, PyObject*> attrs;
// };

// extern "C"
// PyObject* createPyObject(){
//     return new PyObject();
// }

// extern "C"
// void linkPyObject(PyObject* self){
//     self->count+=1;
// }

// extern "C"
// void unlinkPyObject(PyObject* self){
//     self->count-=1;
// }

// PyObject* getAttrOfPyObject(PyObject* self, const char* str, size_t len){
//     return self->attrs[string_view(str, len)];
// }

// void setAttrOfPyObject(PyObject* self, const char* str, size_t len, PyObject* val){
//     self->attrs[string_view(str, len)] = val;
// }

// void delAttrOfPyObject(PyObject* self, const char* str, size_t len){
//     self->attrs.erase(string_view(str, len));
// }

#ifndef printer
#define printer(...)
#endif

struct PyObject{
    size_t ref_count = 1;
    unordered_map<string_view, PyObject*> attrs;
};

struct PyObject{
    size_t count = 1;
    unordered_map<string_view, PyObject*> attrs;
};

// struct PyList:PyObject{
//     vector<PyObject*> value;
// }

// struct PyInt:PyObject{
//     intmax_t value;
// }

// struct PyFloat:PyObject{
//     double value;
// }

// struct PyBytes:PyObject{
//     string value;
// }

// struct PyBool:PyObject{
//     bool value;
// }

PyObject* py_type = nullptr;
PyObject* py_int = nullptr;
PyObject* py_float = nullptr;
PyObject* py_complex = nullptr;
PyObject* py_bool = nullptr;
PyObject* py_list = nullptr;
PyObject* py_tuple = nullptr;
PyObject* py_range = nullptr;
PyObject* py_str = nullptr;
PyObject* py_bytes = nullptr;
PyObject* py_bytearray = nullptr;
PyObject* py_none = nullptr;
PyObject* py_ellipsis = nullptr;

extern "C"
PyObject* getattr(PyObject* self, string_view name){
    return self.attrs[name];
}

extern "C"
void setattr(PyObject* self, string_view name, PyObject* val){
    auto old = self->attrs[name];
    if (old == val){
        return;
    }
    if (old){
        old->count-=1;
    }
    val->count+=1;
    self->attrs[name]=val;
}

extern "C"
void delattr(PyObject* self, string_view name){
    auto old = self->attrs[name];
    if (old){
        old->count-=1;
    }
    self.attrs.erase(name);
}

extern "C"
void create_class(string_view name){
    auto type = new PyObject();
    setattr(type, "__class__", py_type);
}

extern "C"
void start_module(int argc, char**argv){
    py_type = new PyOject();
    setattr(py_type, "__class__", py_type);
    py_int = new PyObject();
    setattr(py_int, "__class__", py_type);
    py_float = new PyObject();
    setattr(py_float, "__class__", py_type);
    py_complex = new PyObject();
    setattr(py_complex, "__class__", py_type);
    py_bool = new PyObject();
    setattr(py_bool, "__class__", py_type);
    py_list = new PyObject();
    setattr(py_list, "__class__", py_type);
    py_tuple = new PyObject();
    setattr(py_tuple, "__class__", py_type);
    py_range = new PyObject();
    setattr(py_range, "__class__", py_type);
    py_str = new PyObject();
    setattr(py_str, "__class__", py_type);
    py_bytes = new PyObject();
    setattr(py_bytes, "__class__", py_type);
    py_bytearray = new PyObject();
    setattr(py_bytearray, "__class__", py_type);



}
printer(start_module)

extern "C"
int stop_module(){
    return 0;
}
printer(stop_module)



#ifndef __clang__
#error "clang required"
#endif

