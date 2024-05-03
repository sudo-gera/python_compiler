#include <bits/stdc++.h>
using namespace std;
template <typename T>

std::string strtype() {
    std::string a=__PRETTY_FUNCTION__;
    return std::string(a.begin()+27,a.end()-1);
}

template <typename T>
std::string strtype([[maybe_unused]]const T&q) {
    return strtype<T>();
}

template<typename T>
auto print_type()->enable_if_t<numeric_limits<T>::is_integer, string>{
    stringstream ss;
    ss << "ir.IntType(" << (is_same_v<decay_t<T>, bool>?1:sizeof(T)*8) << ")";
    return ss.str();
}

template<typename T>
auto print_type()->enable_if_t<is_void_v<T>, string>{
    stringstream ss;
    ss << "ir.VoidType()";
    return ss.str();
}

template<typename T>
auto print_type()->enable_if_t<not is_pointer_v<T> and not is_integral_v<T> and not is_void_v<T>, string>{
    cout << "type_sizes['" << strtype<T>() << "'] = " << sizeof(T) << endl;
    stringstream ss;
    ss << "ir.IntType(8)";
    return ss.str();
}

template<typename T>
auto print_type()->enable_if_t<is_pointer_v<T> and not is_same_v<decay_t<T>, void*>, string>{
    stringstream ss;
    ss << print_type<typename iterator_traits<T>::value_type>();
    ss << ".as_pointer()";
    return ss.str();
}

template<typename T>
auto print_type()->enable_if_t<is_pointer_v<T> and     is_same_v<decay_t<T>, void*>, string>{
    stringstream ss;
    ss << "ir.IntType(8)";
    ss << ".as_pointer()";
    return ss.str();
}

template<typename R, typename...A>
auto print_func([[maybe_unused]]function<R(A...)> f){
    stringstream ss;
    ss << "ir.FunctionType(" << print_type<R>() << ", [";
    string a[] = {print_type<A>()...};
    for (auto&w:a){
        if (&w != a){
            ss << ", ";
        }
        ss << w;
    }
    ss << "])";
    return ss.str();
}

template<typename T>
auto print_func(T&&f, string name){
    stringstream ss;
    ss << "ir.Function(m, ";
    ss << print_func(function(f));
    ss << ", name='" << name << "')";
    return ss.str();
}

template<typename T>
struct get_num{};

template<size_t n>
struct func_printer;

template<size_t n>
struct get_num<func_printer<n>*>{
    constexpr static size_t value = n;
};

template<size_t n>
struct func_printer{
    void operator()(){
        func_printer<get_num<decltype(this)>::value-1>{}();
    }
};

template<>
struct func_printer<__COUNTER__>{
    void operator()(){}
};

#define print_func(f) cout << "external_functions['"#f"'] = " + print_func(f, #f) + "\n";
#define printer(func)\
template<>\
struct func_printer<__COUNTER__>{\
    void operator()(){\
        print_func(func);\
        func_printer<get_num<decltype(this)>::value-1>{}();\
    }\
};
#include "lib.cpp"

int main(){
    print_func(calloc);
    print_func(getchar);
    print_func(putchar);
    print_func(puts);
    func_printer<__COUNTER__>{}();
}
