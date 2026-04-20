# Language Templates

Use these as minimal starting points.
Adapt naming, field style, and logger choice to the target repo.

## Python

```python
import logging
import os
import time

DEBUG = os.getenv("DEBUG", "").lower() in {"1", "true", "yes", "on"}

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG if DEBUG else logging.INFO)


def fetch_user(user_id: str) -> dict:
    started = time.perf_counter()
    if DEBUG:
        logger.debug(
            "fetch_user start",
            extra={"function": "fetch_user", "step": "entry", "user_id": user_id},
        )
    try:
        if DEBUG:
            logger.debug(
                "fetch_user query",
                extra={"function": "fetch_user", "step": "query-db", "user_id": user_id},
            )
        result = {"user_id": user_id, "name": "demo"}
        elapsed_ms = round((time.perf_counter() - started) * 1000, 2)
        logger.info(
            "fetch_user ok",
            extra={"function": "fetch_user", "status": "ok", "elapsed_ms": elapsed_ms},
        )
        return result
    except Exception:
        logger.exception("fetch_user fail", extra={"function": "fetch_user", "status": "fail"})
        raise
```

## JavaScript

```javascript
const DEBUG = /^(1|true|yes|on)$/i.test(process.env.DEBUG || "");

function log(level, message, fields = {}) {
  if (level === "debug" && !DEBUG) return;
  console[level === "debug" ? "debug" : level](
    JSON.stringify({ level, message, ...fields })
  );
}

async function fetchUser(userId) {
  const started = Date.now();
  log("debug", "fetchUser start", { function: "fetchUser", step: "entry", userId });
  try {
    log("debug", "fetchUser query", { function: "fetchUser", step: "query-db", userId });
    const result = { userId, name: "demo" };
    log("info", "fetchUser ok", {
      function: "fetchUser",
      status: "ok",
      elapsed_ms: Date.now() - started,
    });
    return result;
  } catch (error) {
    log("error", "fetchUser fail", {
      function: "fetchUser",
      status: "fail",
      error: error.message,
    });
    throw error;
  }
}
```

## TypeScript

```ts
const DEBUG = /^(1|true|yes|on)$/i.test(process.env.DEBUG ?? "");

type LogFields = Record<string, unknown>;

function log(level: "debug" | "info" | "warn" | "error", message: string, fields: LogFields = {}) {
  if (level === "debug" && !DEBUG) return;
  const payload = { level, message, ...fields };
  console[level === "debug" ? "debug" : level](JSON.stringify(payload));
}

export async function fetchUser(userId: string): Promise<{ userId: string; name: string }> {
  const started = Date.now();
  log("debug", "fetchUser start", { function: "fetchUser", step: "entry", userId });
  try {
    log("debug", "fetchUser query", { function: "fetchUser", step: "query-db", userId });
    const result = { userId, name: "demo" };
    log("info", "fetchUser ok", {
      function: "fetchUser",
      status: "ok",
      elapsed_ms: Date.now() - started,
    });
    return result;
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    log("error", "fetchUser fail", {
      function: "fetchUser",
      status: "fail",
      error: message,
    });
    throw error;
  }
}
```

## Go

```go
package main

import (
	"log/slog"
	"os"
	"strings"
	"time"
)

var debugEnabled = strings.EqualFold(os.Getenv("DEBUG"), "true") || os.Getenv("DEBUG") == "1"
var logger = slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
	Level: func() slog.Level {
		if debugEnabled {
			return slog.LevelDebug
		}
		return slog.LevelInfo
	}(),
}))

func fetchUser(userID string) (map[string]string, error) {
	started := time.Now()
	logger.Debug("fetchUser start", "function", "fetchUser", "step", "entry", "user_id", userID)
	logger.Debug("fetchUser query", "function", "fetchUser", "step", "query-db", "user_id", userID)
	result := map[string]string{"user_id": userID, "name": "demo"}
	logger.Info("fetchUser ok", "function", "fetchUser", "status", "ok", "elapsed_ms", time.Since(started).Milliseconds())
	return result, nil
}
```

## Java

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);
    private static final boolean DEBUG = Boolean.parseBoolean(System.getenv().getOrDefault("DEBUG", "false"));

    public User fetchUser(String userId) {
        long started = System.nanoTime();
        if (DEBUG) {
            log.debug("function=fetchUser step=entry userId={}", userId);
            log.debug("function=fetchUser step=query-db userId={}", userId);
        }
        try {
            User result = new User(userId, "demo");
            long elapsedMs = (System.nanoTime() - started) / 1_000_000;
            log.info("function=fetchUser status=ok elapsed_ms={}", elapsedMs);
            return result;
        } catch (RuntimeException ex) {
            log.error("function=fetchUser status=fail message={}", ex.getMessage(), ex);
            throw ex;
        }
    }
}
```

## Kotlin

```kotlin
import org.slf4j.LoggerFactory

private val log = LoggerFactory.getLogger("UserService")
private val DEBUG = System.getenv("DEBUG")?.lowercase() in setOf("1", "true", "yes", "on")

data class User(val userId: String, val name: String)

fun fetchUser(userId: String): User {
    val started = System.nanoTime()
    if (DEBUG) {
        log.debug("function=fetchUser step=entry userId={}", userId)
        log.debug("function=fetchUser step=query-db userId={}", userId)
    }
    return try {
        val result = User(userId, "demo")
        val elapsedMs = (System.nanoTime() - started) / 1_000_000
        log.info("function=fetchUser status=ok elapsed_ms={}", elapsedMs)
        result
    } catch (ex: Exception) {
        log.error("function=fetchUser status=fail message={}", ex.message, ex)
        throw ex
    }
}
```

## Rust

```rust
use std::env;
use std::time::Instant;
use tracing::{debug, error, info};

fn debug_enabled() -> bool {
    matches!(env::var("DEBUG").unwrap_or_default().to_lowercase().as_str(), "1" | "true" | "yes" | "on")
}

fn fetch_user(user_id: &str) -> Result<String, String> {
    let started = Instant::now();
    if debug_enabled() {
        debug!(function = "fetch_user", step = "entry", user_id, "fetch_user start");
        debug!(function = "fetch_user", step = "query-db", user_id, "fetch_user query");
    }
    let result = "demo".to_string();
    info!(function = "fetch_user", status = "ok", elapsed_ms = started.elapsed().as_millis(), "fetch_user ok");
    Ok(result)
}
```

## C

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static int debug_enabled(void) {
    const char *value = getenv("DEBUG");
    return value && (
        strcmp(value, "1") == 0 ||
        strcasecmp(value, "true") == 0 ||
        strcasecmp(value, "yes") == 0 ||
        strcasecmp(value, "on") == 0
    );
}

#define LOG_INFO(fmt, ...)  fprintf(stderr, "INFO " fmt "\n", ##__VA_ARGS__)
#define LOG_ERROR(fmt, ...) fprintf(stderr, "ERROR " fmt "\n", ##__VA_ARGS__)
#define LOG_DEBUG(fmt, ...) do { if (debug_enabled()) fprintf(stderr, "DEBUG " fmt "\n", ##__VA_ARGS__); } while (0)

int fetch_user(const char *user_id) {
    clock_t started = clock();
    LOG_DEBUG("function=fetch_user step=entry user_id=%s", user_id);
    LOG_DEBUG("function=fetch_user step=query-db user_id=%s", user_id);
    LOG_INFO("function=fetch_user status=ok elapsed_ms=%ld", (long)((clock() - started) * 1000 / CLOCKS_PER_SEC));
    return 0;
}
```

## C++

```cpp
#include <chrono>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>

inline bool debug_enabled() {
    const char* value = std::getenv("DEBUG");
    if (!value) return false;
    return std::strcmp(value, "1") == 0 || std::strcmp(value, "true") == 0;
}

inline void log_line(const char* level, const std::string& message) {
    std::cerr << level << " " << message << "\n";
}

void fetchUser(const std::string& userId) {
    const auto started = std::chrono::steady_clock::now();
    if (debug_enabled()) {
        log_line("DEBUG", "function=fetchUser step=entry user_id=" + userId);
        log_line("DEBUG", "function=fetchUser step=query-db user_id=" + userId);
    }
    const auto elapsedMs = std::chrono::duration_cast<std::chrono::milliseconds>(
        std::chrono::steady_clock::now() - started
    ).count();
    log_line("INFO", "function=fetchUser status=ok elapsed_ms=" + std::to_string(elapsedMs));
}
```

## C#

```csharp
using System;
using Microsoft.Extensions.Logging;

public sealed class UserService
{
    private readonly ILogger<UserService> _logger;
    private readonly bool _debug;

    public UserService(ILogger<UserService> logger)
    {
        _logger = logger;
        _debug = string.Equals(Environment.GetEnvironmentVariable("DEBUG"), "true", StringComparison.OrdinalIgnoreCase)
            || Environment.GetEnvironmentVariable("DEBUG") == "1";
    }

    public User FetchUser(string userId)
    {
        var started = DateTime.UtcNow;
        if (_debug)
        {
            _logger.LogDebug("function=FetchUser step=entry userId={UserId}", userId);
            _logger.LogDebug("function=FetchUser step=query-db userId={UserId}", userId);
        }

        try
        {
            var result = new User(userId, "demo");
            _logger.LogInformation(
                "function=FetchUser status=ok elapsed_ms={ElapsedMs}",
                (DateTime.UtcNow - started).TotalMilliseconds
            );
            return result;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "function=FetchUser status=fail");
            throw;
        }
    }
}
```

## PHP

```php
<?php

$debug = in_array(strtolower(getenv('DEBUG') ?: ''), ['1', 'true', 'yes', 'on'], true);

function log_message(string $level, string $message, array $fields = []): void
{
    global $debug;
    if ($level === 'debug' && !$debug) {
        return;
    }
    error_log(json_encode(array_merge(['level' => $level, 'message' => $message], $fields)));
}

function fetchUser(string $userId): array
{
    $started = microtime(true);
    log_message('debug', 'fetchUser start', ['function' => 'fetchUser', 'step' => 'entry', 'user_id' => $userId]);
    try {
        log_message('debug', 'fetchUser query', ['function' => 'fetchUser', 'step' => 'query-db', 'user_id' => $userId]);
        $result = ['user_id' => $userId, 'name' => 'demo'];
        log_message('info', 'fetchUser ok', [
            'function' => 'fetchUser',
            'status' => 'ok',
            'elapsed_ms' => round((microtime(true) - $started) * 1000, 2),
        ]);
        return $result;
    } catch (Throwable $e) {
        log_message('error', 'fetchUser fail', ['function' => 'fetchUser', 'status' => 'fail', 'error' => $e->getMessage()]);
        throw $e;
    }
}
```

## Shell

```bash
#!/usr/bin/env bash
set -euo pipefail

DEBUG="${DEBUG:-false}"

log_debug() {
  if [[ "$DEBUG" =~ ^(1|true|yes|on)$ ]]; then
    printf 'DEBUG %s\n' "$*"
  fi
}

log_info() {
  printf 'INFO %s\n' "$*"
}

log_error() {
  printf 'ERROR %s\n' "$*" >&2
}

fetch_user() {
  local user_id="$1"
  local started
  started="$(date +%s%3N)"
  log_debug "function=fetch_user step=entry user_id=${user_id}"
  log_debug "function=fetch_user step=query-db user_id=${user_id}"
  log_info "function=fetch_user status=ok elapsed_ms=$(( $(date +%s%3N) - started ))"
}
```
