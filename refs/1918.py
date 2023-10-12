import sys
import re
l = sys.stdin.readline().strip()
def parse(infix_exp):
    binary_operators = ['+', '-', '*', '/']
    precedences = {
        '+': 1, '-': 1,
        '*': 2, '/': 2,
        'u-': 3,
    }
    rpn, opstack = [], []
    lexer = re.compile(r"[-+*/()]|\w+")
    tokens = lexer.findall(infix_exp)
    for idx, tok in enumerate(tokens):
        if tok.isalpha():
            rpn.append((tok))
            continue

        if tok == '-' and (idx == 0 or tokens[idx-1] in binary_operators + ['(']):
            opstack.append('-')
        elif tok in binary_operators:
            while opstack and opstack[-1] != '(' and precedences[opstack[-1]] >= precedences[tok]:
                rpn.append(opstack.pop())
            opstack.append(tok)
        elif tok == '(':
            opstack.append(tok)
        else: # tok == ')'
            while opstack:
                top = opstack.pop()
                if top == '(':
                    break
                rpn.append(top)
    while opstack:
        rpn.append(opstack.pop())
    return rpn

print("".join(parse(l)))
