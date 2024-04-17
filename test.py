# async def putchar(c: 'ir.IntType(32)') -> 'ir.IntType(32)':
#     pass
# async def getchar() -> 'ir.IntType(32)':
#     pass
# putchar(getchar()-4294967295)
# putchar(10)
def q():
    x=4
    def w():
        def e():
            nonlocal x
            x = 0
        e()
    w()
    print(x)
q()

