#include <bits/stdc++.h>
using namespace std;

// // using str = pair<const char*, size_t>;

// // struct PyObject{
// //     size_t count = 1;
// //     unordered_map<string_view, PyObject*> attrs;
// // };

// // extern "C"
// // PyObject* createPyObject(){
// //     return new PyObject();
// // }

// // extern "C"
// // void linkPyObject(PyObject* self){
// //     self->count+=1;
// // }

// // extern "C"
// // void unlinkPyObject(PyObject* self){
// //     self->count-=1;
// // }

// // PyObject* getAttrOfPyObject(PyObject* self, const char* str, size_t len){
// //     return self->attrs[string_view(str, len)];
// // }

// // void setAttrOfPyObject(PyObject* self, const char* str, size_t len, PyObject* val){
// //     self->attrs[string_view(str, len)] = val;
// // }

// // void delAttrOfPyObject(PyObject* self, const char* str, size_t len){
// //     self->attrs.erase(string_view(str, len));
// // }

// #ifndef printer
// #define printer(...)
// #endif

// struct PyObject{
//     size_t ref_count = 1;
//     unordered_map<string_view, PyObject*> attrs;
// };

// struct PyObject{
//     size_t count = 1;
//     unordered_map<string_view, PyObject*> attrs;
// };

// // struct PyList:PyObject{
// //     vector<PyObject*> value;
// // }

// // struct PyInt:PyObject{
// //     intmax_t value;
// // }

// // struct PyFloat:PyObject{
// //     double value;
// // }

// // struct PyBytes:PyObject{
// //     string value;
// // }

// // struct PyBool:PyObject{
// //     bool value;
// // }

// PyObject* py_type = nullptr;
// PyObject* py_int = nullptr;
// PyObject* py_float = nullptr;
// PyObject* py_complex = nullptr;
// PyObject* py_bool = nullptr;
// PyObject* py_list = nullptr;
// PyObject* py_tuple = nullptr;
// PyObject* py_range = nullptr;
// PyObject* py_str = nullptr;
// PyObject* py_bytes = nullptr;
// PyObject* py_bytearray = nullptr;
// PyObject* py_none = nullptr;
// PyObject* py_ellipsis = nullptr;

// extern "C"
// PyObject* getattr(PyObject* self, string_view name){
//     return self.attrs[name];
// }

// extern "C"
// void setattr(PyObject* self, string_view name, PyObject* val){
//     auto old = self->attrs[name];
//     if (old == val){
//         return;
//     }
//     if (old){
//         old->count-=1;
//     }
//     val->count+=1;
//     self->attrs[name]=val;
// }

// extern "C"
// void delattr(PyObject* self, string_view name){
//     auto old = self->attrs[name];
//     if (old){
//         old->count-=1;
//     }
//     self.attrs.erase(name);
// }

// extern "C"
// void create_class(string_view name){
//     auto type = new PyObject();
//     setattr(type, "__class__", py_type);
// }

// extern "C"
// void start_module(int argc, char**argv){
//     py_type = new PyOject();
//     setattr(py_type, "__class__", py_type);
//     py_int = new PyObject();
//     setattr(py_int, "__class__", py_type);
//     py_float = new PyObject();
//     setattr(py_float, "__class__", py_type);
//     py_complex = new PyObject();
//     setattr(py_complex, "__class__", py_type);
//     py_bool = new PyObject();
//     setattr(py_bool, "__class__", py_type);
//     py_list = new PyObject();
//     setattr(py_list, "__class__", py_type);
//     py_tuple = new PyObject();
//     setattr(py_tuple, "__class__", py_type);
//     py_range = new PyObject();
//     setattr(py_range, "__class__", py_type);
//     py_str = new PyObject();
//     setattr(py_str, "__class__", py_type);
//     py_bytes = new PyObject();
//     setattr(py_bytes, "__class__", py_type);
//     py_bytearray = new PyObject();
//     setattr(py_bytearray, "__class__", py_type);



// }
// printer(start_module)

// extern "C"
// int stop_module(){
//     return 0;
// }
// printer(stop_module)



// #ifndef __clang__
// #error "clang required"
// #endif

#ifndef printer
#define printer(...)
#endif

// extern "C"
// int64_t double_to_int64(double val){
//     return val;
// }
// printer(double_to_int64);

// extern "C"
// double int64_to_double(int64_t val){
//     return val;
// }
// printer(int64_to_double);

union unknown_value{
    int64_t ival;
    double fval;
    void* oval;
};

struct py_object{
    size_t count = 0;
    unknown_value data{0};
};

extern "C"
// py_object* create_py_object(){
    // return new py_object();
unknown_value* create_py_object(){
    return new unknown_value();
}
printer(create_py_object);

extern "C"
void get_static_size_of_unknown_value(unknown_value*a){}
printer(get_static_size_of_unknown_value);

struct py_function{
    size_t code = 0;
    vector<unknown_value*> closure;
};

extern "C"
py_function* create_py_function(size_t code){
    return new py_function{code};
}
printer(create_py_function);

extern "C"
void add_cell_to_function(py_function* func, unknown_value* val){
    func->closure.push_back(val);
    // cout << func << " " << func->closure.size() << endl;
}
printer(add_cell_to_function);

extern "C"
size_t get_code_from_function(py_function* func){
    return func->code;
}
printer(get_code_from_function);

extern "C"
unknown_value* get_cell_from_function(py_function* func, size_t index){
    // cout << func << " " << func->closure.size() << " " << index << endl;
    return func->closure[index];
}
printer(get_cell_from_function);

extern "C"
void print_int(int64_t val){
    cout << val << endl;
}
printer(print_int);





