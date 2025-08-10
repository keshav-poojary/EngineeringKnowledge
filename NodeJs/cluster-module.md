# JavaScript and Node.js Concurrency Concepts

## JavaScript is Single-Threaded
- JavaScript runs on a single thread by design.
- This means only one piece of code executes at a time in the main thread.
- Concurrency is handled via the **event loop**, **callbacks**, **promises**, and **async/await**.

---

## Node.js Cluster Module

- Node.js provides the **`cluster`** module to create **child processes** (workers).
- Each worker is a separate Node.js process with:
  - Its own **event loop**
  - Its own **V8 engine instance**
  - Its own **memory heap**

### Master-Worker Architecture
- The **master process** manages workers:
  - Spawns child processes
  - Distributes incoming connections (e.g., HTTP requests)
  - Listens for worker exits and can respawn them for reliability

### Benefits of Clustering
- Utilizes multi-core CPUs by running multiple Node.js processes in parallel.
- Improves scalability and throughput.
- Each child process runs independently, so if one crashes, others continue working.

### Important Notes
- Workers do **not** share memory; communication happens via IPC (Inter-Process Communication).
- Workers have their own event loops and V8 instances — truly isolated.
- The cluster module is used to overcome Node.js’s single-threaded nature for CPU-intensive tasks.

---

### Summary

| Concept                | Details                                 |
|------------------------|-----------------------------------------|
| JavaScript             | Single-threaded, runs in a single event loop |
| Node.js Cluster Module | Creates multiple child processes (workers)  |
| Master process         | Manages and distributes tasks to workers    |
| Worker processes       | Each has own event loop, V8, memory           |
| Communication          | Happens via IPC, no shared memory            |

