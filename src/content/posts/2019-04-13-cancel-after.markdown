---
title: Async/Await easy cancellation in c#
layout: post
date: 2019-04-13
toc: false
images:
tags:
  - csharp
  - EN
---


> **I am not the original author of this extension**

Usage
===
```csharp
await ATask().CancelAfter(2000);
```

Code
===

```csharp
    public static class TaskCancellationExtension
    {
        /// <summary>
        /// add cancellation functionality to Task<T>
        /// </summary>
        /// <param name="task"></param>
        /// <param name="cancellationToken"></param>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        /// <exception cref="OperationCanceledException"></exception>
        public static async Task<T> CancelAfter<T>(
            this Task<T> task, CancellationToken cancellationToken)
        {
            var tcs = new TaskCompletionSource<bool>();
            using (cancellationToken.Register( s => ((TaskCompletionSource<bool>) s).TrySetResult(true), tcs))
                if (task != await Task.WhenAny(task, tcs.Task))
                    throw new OperationCanceledException(cancellationToken);
            return await task;
        }


        /// <summary>
        /// add cancellation functionality to Tasks 
        /// </summary>
        /// <param name="task"></param>
        /// <param name="cancellationToken"></param>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        /// <exception cref="OperationCanceledException"></exception>
        public static async Task CancelAfter( this Task task, CancellationToken cancellationToken)
        {
            var tcs = new TaskCompletionSource<bool>();
            using (cancellationToken.Register( s => ((TaskCompletionSource<bool>) s).TrySetResult(true), tcs))
                if (task != await Task.WhenAny(task, tcs.Task))
                    throw new OperationCanceledException(cancellationToken);
            await task;
        }


        /// <summary>
        /// add cancellation functionality to Task<T>
        /// </summary>
        /// <param name="task"></param>
        /// <param name="milliseconds"></param>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        /// <exception cref="OperationCanceledException"></exception>
        public static async Task<T> CancelAfter<T>( this Task<T> task, int milliseconds)
        {
            var cts = new CancellationTokenSource();
            cts.CancelAfter(milliseconds);
            var tcs = new TaskCompletionSource<bool>();
            using (cts.Token.Register( s => ((TaskCompletionSource<bool>) s).TrySetResult(true), tcs))
                if (task != await Task.WhenAny(task, tcs.Task))
                    throw new OperationCanceledException(cts.Token);
            return await task;
        }


        /// <summary>
        /// add cancellation functionality to Task<T>
        /// </summary>
        /// <param name="task"></param>
        /// <param name="milliseconds"></param>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        /// <exception cref="OperationCanceledException"></exception>
        public static async Task CancelAfter( this Task task, int milliseconds)
        {
            var cts = new CancellationTokenSource();
            cts.CancelAfter(milliseconds);
            var tcs = new TaskCompletionSource<bool>();
            using (cts.Token.Register( s => ((TaskCompletionSource<bool>) s).TrySetResult(true), tcs))
                if (task != await Task.WhenAny(task, tcs.Task))
                    throw new OperationCanceledException(cts.Token);
            await task;
        }
    }

```