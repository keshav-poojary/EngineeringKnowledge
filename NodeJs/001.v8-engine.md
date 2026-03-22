# How JavaScript Code is Understood by Computers

- JavaScript code is written in a human-readable form but **computers understand only machine code**.
- To run JavaScript, it must be **converted into machine code** that the computer's processor can execute.
- This conversion is done by **JavaScript engines** embedded inside browsers.

## Popular JavaScript Engines

| Engine Name       | Browser / Platform         | Developer      |
|-------------------|----------------------------|----------------|
| **V8**            | Google Chrome, Node.js      | Google (C++)   |
| **SpiderMonkey**  | Mozilla Firefox             | Mozilla        |
| **JavaScriptCore**| Safari                     | Apple          |
| **Chakra**        | Internet Explorer, Edge (Legacy) | Microsoft  |

## How V8 Works

- Written in **C++** by Google.
- Uses a **Just-In-Time (JIT) compiler** to convert JavaScript code to **machine code** at runtime.
- This allows for **fast execution** of JavaScript.

---

## Summary

| Concept          | Explanation                                   |
|------------------|-----------------------------------------------|
| JavaScript Engines | Convert JS code to machine code for execution |
| V8                | Google’s JS engine used in Chrome and Node.js |
| JIT Compiler      | Compiles JS to machine code on the fly for speed |
