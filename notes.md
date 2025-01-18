# Assembly

## What is a segment

A segment is a contiguous section of memory with specific purposes and
permissions. Think of it like dividing a building into floors where each floor
has a specific purpose:
    
**Memory Segments in a typical program:**

```
Virtual Memory Layout
+------------------+ Higher addresses
|      Stack       | - Function call data
|        ↓         | - Local variables
|                  | - Grows downward
+------------------+
|                  | 
|       ↑          | 
|      Heap        | - Dynamic allocations
+------------------+
|      .bss        | - Uninitialized data
+------------------+
|     .data        | - Initialized variables
+------------------+
|     .text        | - Program code
+------------------+ Lower addresses
```
    
Each segment has specific attributes:
1. `.text` segment:
   - Read-only
   - Contains executable instructions
   - Cannot be modified during execution (prevents code corruption)

2. `.data` segment:
   - Read-write
   - Contains initialized variables
   - Example: your `msg db 'Hello, x86 Assembly!', 0xa`

3. `.bss` segment:
   - Read-write
   - Contains uninitialized data
   - Takes no space in executable file

Historical Context:
- Early x86 processors used physical segmentation
- Memory was divided into 64KB segments
- Segments were accessed using segment registers (CS, DS, SS, ES)

Modern Systems:
- Use virtual memory with "flat" address space
- Segments are more logical divisions
- Still maintain different permissions for different segments
- Protected by the Memory Management Unit (MMU)

Think of it like:
- `.text` is like a library's reference section (read-only)
- `.data` is like a workbook (read-write)
- Stack is like a scratch pad (temporary work)
- Each with its own security guard (MMU) enforcing access rules

Some questions:

- A 'Label' is like a variable?
- Why do we need to define byte
- What is the purpose of 0xa (the hexadecimal for 10)
    
1. "Is a Label like a variable?"
- Not exactly. A label is more like a "bookmark" or "address marker" in memory
- Unlike variables which can change value, labels are fixed memory addresses
- Think of it like:
  ```
  Memory:
  Address    Content
  1000       'H'
  1001       'e'
  1002       'l'
  1003       'l'
  1004       'o'
  
  msg -----> points to address 1000
  ```
- When you use `msg` in code, you're really using its address
- In higher-level languages, this would be like a constant pointer

2. "Why do we need to define byte?"
- `db` (Define Byte) tells the assembler how to store the data
- We have options:
  ```nasm
  db  ; Define Byte  (1 byte  = 8 bits)
  dw  ; Define Word  (2 bytes = 16 bits)
  dd  ; Define Double(4 bytes = 32 bits)
  dq  ; Define Quad (8 bytes = 64 bits)
  ```
- For text, we use `db` because:
  - ASCII characters are 1 byte each
  - It's most memory efficient
  - Example:
    ```nasm
    msg db 'H'    ; Stores 72 (ASCII for 'H') in one byte
    num dd 12345  ; Stores number using 4 bytes
    ```

3. "What is the purpose of 0xa?"
- `0xa` is the newline character in hexadecimal
- Why it exists:
  - ASCII uses 0-127 to represent characters
  - 10 (decimal) or 0xa (hex) is the "Line Feed" character
  - When printed, it moves cursor to start of next line
- Why hexadecimal:
  ```
  Decimal: 10
  Binary:  00001010
  Hex:     0A
  ```
  - Hex is more compact than binary
  - Each hex digit represents 4 bits
  - Common in low-level programming

Your string:
```nasm
msg db 'Hello, x86 Assembly!', 0xa
```
In memory looks like:
```
Memory:    H   e   l   l   o   ,       x   8   6   ...  !  \n
ASCII:     72  101 108 108 111 44  32  120 56  54  ... 33  10
Hex:       48  65  6C  6C  6F  2C  20  78  38  36  ... 21  0A
```

When this prints:
```
Hello, x86 Assembly!
█                    <- Cursor moves here because of 0xa
```

This is why in C you see `\n` and in Assembly we use `0xa` - they're the same thing, just written differently.
