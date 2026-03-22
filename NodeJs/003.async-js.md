# JavaScript and Node.js Execution Model Explained

## JavaScript Basics

- **By default, JavaScript is:**
  - **Synchronous:** Code runs line by line in order.
  - **Single-threaded:** Only one call stack is used to execute code.
  - **Blocking:** Long-running operations block the execution of further code until they finish.

---

## How Does Node.js Handle Asynchronous Operations?

- Node.js uses **libuv**, a C library that provides an **event-driven, non-blocking I/O model**.
- **libuv** uses an internal **thread pool** (default 4 threads) to perform expensive or blocking operations asynchronously.
- This allows Node.js to perform I/O operations (like file system, DNS, network) without blocking the main thread.

---

## Operations That Use the Thread Pool

| Operation                         | Description                                          |
| --------------------------------- | ---------------------------------------------------- |
| File system operations            | `fs.readFile()`, `fs.writeFile()`, `fs.stat()`, etc. |
| DNS lookups (non-system resolver) | `dns.lookup()` with custom DNS resolution            |
| Cryptographic operations          | `crypto.pbkdf2()`, `crypto.scrypt()`, etc.           |
| Compression                       | zlib compression and decompression                   |
| Child process I/O                 | Pipes and other I/O related to child processes       |

---

## How the Thread Pool Works

1. Main thread schedules an async operation requiring the thread pool.
2. libuv assigns the task to a free thread in the thread pool.
3. The thread executes the blocking operation.
4. Upon completion, libuv queues the callback on the event loop.
5. The event loop executes the callback on the main thread.

---

## Default Thread Pool Size

- The default size of the thread pool is **4** threads.
- At most 4 thread-pool tasks run in parallel.
- Additional tasks wait in queue until a thread is free.

---

## Configuring Thread Pool Size

- You can set the thread pool size using the environment variable:

  ```bash
  UV_THREADPOOL_SIZE=8 node app.js
  ```