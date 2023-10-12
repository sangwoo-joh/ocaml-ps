import sys
def f():
    return sys.stdin.readline().strip()

total = int(f())
exp = f()
var_map = {}
for i in range(total):
    var_map[chr(65+i)] = int(f())

op_map = {
    '*': lambda x, y: x * y,
    '+': lambda x, y: x + y,
    '-': lambda x, y: x - y,
    '/': lambda x, y: x / y,
}

stack = []
for e in exp:
    if e.isalpha():
        stack.append(var_map[e])
    else:
        # e is an operator
        v2, v1 = stack.pop(), stack.pop()
        v = op_map[e](v1, v2)
        stack.append(v)

print(f'{stack[0]:.2f}')
