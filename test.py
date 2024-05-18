def print(n):
    if n == 0:
        ().putchar(48)
    else:
        if n < 0:
            ().putchar(45)
            n = -n
        m = 1
        while m <= n:
            m *= 10
        m //= 10
        while m:
            ().putchar(n // m + 48)
            n %= m
            m //= 10
    ().putchar(10)

result = 0
def wrapper(s):
    pass

def partial(f, a):
    global wrapper
    def wrapper(s):
        f(a, s)

def sum(a, s):
    global result # works as return
    result = a + s

partial(sum, 5)
add_5 = wrapper

partial(sum, 6)
add_6 = wrapper

result = 0
add_5(3)
print(result)

result = 0
add_6(3)
print(result)

