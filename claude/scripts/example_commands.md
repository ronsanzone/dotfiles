# Log Analysis Commands - Examples with test_errors.json

## 1. Basic Error Analysis

### Find all errors in the logs
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py errors /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json
```

### Filter errors by specific service
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py errors /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json --service backend
```

### Output to JSON for further processing
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py errors /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | python3 -m json.tool
```

## 2. Correlation Analysis

### Analyze all correlations
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py correlate /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json
```

### Track specific correlation ID
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py correlate /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json --correlation-id "18709ea341baf68c035bad8c"
```

## 3. Cascade Detection (for finding cascading failures)

### Default 5-second window
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py cascade /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json
```

### Custom time window (10 seconds)
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py cascade /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json --window 10
```

## 4. Performance Profiling

### Profile request performance
```bash
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py profile /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json
```

## Claude Agent Usage Examples

### When Claude's Splunk Analyzer agent would use these:

#### Quick Error Count
```bash
# Count total errors
grep -c '"error"' /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json

# Count specific error types
grep -o '"grpc.code":"[^"]*"' /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | sort | uniq -c
```

#### Find Specific Correlation
```bash
# Quick search for a correlation ID
grep '"correlationID":"18709ea341baf68c035bad8c"' /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | head -5
```

#### Extract Error Messages
```bash
# Get unique error messages
python3 -c "
import json
with open('/Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json') as f:
    for line in f:
        data = json.loads(line)
        log = json.loads(data['result']['_raw'])
        if 'error' in log:
            print(log['error'][:100])
" | sort | uniq
```

## Advanced Analysis Patterns

### 1. Time Range Analysis
```bash
# Find errors in specific time range
python3 -c "
import json
from datetime import datetime

target_hour = '21:31'
with open('/Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json') as f:
    for line in f:
        data = json.loads(line)
        log = json.loads(data['result']['_raw'])
        if 'time' in log and target_hour in log['time']:
            if 'error' in log or 'grpc.error_message' in log:
                print(f\"{log.get('time', '')}: {log.get('error', log.get('grpc.error_message', 'Unknown'))[:80]}\")
"
```

### 2. Service Error Distribution
```bash
# Count errors by service/logger
python3 -c "
import json
from collections import Counter

services = Counter()
with open('/Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json') as f:
    for line in f:
        data = json.loads(line)
        log = json.loads(data['result']['_raw'])
        if 'error' in log or 'grpc.error_message' in log:
            service = log.get('logger', 'unknown')
            services[service] += 1

for service, count in services.most_common():
    print(f'{service}: {count} errors')
"
```

### 3. Error Pattern Matching
```bash
# Find S3-related errors
grep -i "s3\|HeadObject\|aws" /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | wc -l

# Find timeout/cancellation errors
grep -i "context canceled\|timeout\|deadline" /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | wc -l
```

### 4. Extract Call Stack Information
```bash
# Get all unique error locations (callers)
python3 -c "
import json
from collections import Counter

callers = Counter()
with open('/Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json') as f:
    for line in f:
        data = json.loads(line)
        log = json.loads(data['result']['_raw'])
        if 'caller' in log and ('error' in log or 'grpc.error_message' in log):
            callers[log['caller']] += 1

print('Top Error Locations:')
for caller, count in callers.most_common(10):
    print(f'  {caller}: {count} errors')
"
```

## Pipeline Examples (Combining Commands)

### Find and analyze problematic correlations
```bash
# First find correlations with most errors
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py correlate /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | \
  python3 -c "import sys, json; data=json.load(sys.stdin); [print(c['correlation_id']) for c in data.get('problem_correlations', [])]"
```

### Generate error summary report
```bash
# Full error report with formatting
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py errors /Users/ron.sanzone/code/dotfiles/claude/scripts/test_errors.json | \
  python3 -c "
import sys, json
data = json.load(sys.stdin)
summary = data['summary']
print('=== ERROR ANALYSIS REPORT ===')
print(f\"Total Errors: {summary['total_errors']}\")
print(f\"Services Affected: {summary['services_with_errors']}\")
print('\nError Types:')
for t, c in summary.get('error_types', {}).items():
    print(f'  - {t}: {c}')
print('\nTop 3 Error Messages:')
for i, (msg, count) in enumerate(list(data['top_error_messages'].items())[:3], 1):
    print(f'  {i}. [{count}x] {msg[:60]}...')
"
```

## When Claude Would Use Each Command

### Initial Investigation
```bash
# Quick overview
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py errors test_errors.json
```

### Deep Dive on Specific Issue
```bash
# If user asks about a specific correlation
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py correlate test_errors.json --correlation-id "CORRELATION_ID_HERE"
```

### Performance Issues
```bash
# When investigating slowness
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py profile test_errors.json
```

### System-Wide Failures
```bash
# When looking for cascade failures
python3 /Users/ron.sanzone/code/dotfiles/claude/scripts/log_analysis_lib.py cascade test_errors.json --window 10
```