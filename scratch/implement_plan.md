# Implement Plan

You are tasked with implementing an approved technical plan from `~/notes/plans/`. These plans contain phases with specific changes and success criteria.

## Getting Started

When given a plan path:
1. Read the plan completely and check for any existing checkmarks (- [x])
2. Read the original ticket and all files mentioned in the plan (FULLY, no limit/offset)
3. Create a TodoWrite list matching the plan's phases
4. Start implementing from the first unchecked item

If no plan path provided, ask:
```
Please provide the path to the implementation plan you'd like me to execute.
Plans are typically in: ~/notes/plans/
```

## Implementation Philosophy

Plans are carefully designed, but reality can be messy. Your approach:
- **Follow the plan's intent** while adapting to what you find
- **Complete each phase fully** before moving to the next
- **Verify your work** makes sense in the broader context
- **Update checkboxes** in both the plan and your todos as you progress

## Phase Execution Process

For each phase:

### 1. Understand the Phase
- Read the phase objectives and success criteria
- Identify all files that need modification
- Understand the expected outcome

### 2. Implement Changes
- Make the specified code changes
- Follow existing patterns in the codebase
- Maintain consistency with surrounding code

### 3. Verify Success
Run automated verification first:
```bash
# Common verification commands
make check test
make lint
make typecheck
```

Fix any issues before proceeding.

### 4. Update Progress
- Check off completed items in the plan using Edit: `- [x]`
- Update your TodoWrite list
- Document any deviations or discoveries

## Handling Mismatches

When the plan doesn't match reality:

### Stop and Communicate
```
Issue in Phase [N]:
Expected: [what the plan says]
Found: [actual situation]
Impact: [why this matters]

Proposed solution:
[Your recommendation]

Should I proceed with this approach?
```

### Common Mismatches
- **File structure changed**: Adapt to new structure
- **Dependencies missing**: Install or note requirement
- **Pattern deprecated**: Use current best practice
- **Feature already exists**: Verify and skip if appropriate

## Verification Strategy

### Automated Checks (Run First)
- Unit tests for the modified components
- Linting and formatting checks
- Type checking or compilation
- Integration tests if specified

### Manual Verification Notes
- Document what needs human verification
- Note any UI/UX aspects to test
- Flag performance considerations

## Progress Tracking

### Use TodoWrite Effectively
```
Phase 1: [Name] - in_progress
  - Modify file A
  - Update tests
  - Run verification
Phase 2: [Name] - pending
Phase 3: [Name] - pending
```

### Batch Your Work
- Implement related changes together
- Run verification at natural stopping points
- Don't let verification interrupt flow

## Resuming Interrupted Work

If the plan has existing checkmarks:
1. Trust that completed work is done correctly
2. Pick up from the first unchecked item
3. Verify previous work only if something seems off
4. Continue forward momentum

## Communication Guidelines

### Regular Updates
After completing each phase:
```
✅ Phase [N] complete:
- [Key change implemented]
- All automated tests passing
- [Any notable findings]

Moving to Phase [N+1]...
```

### Final Summary
When implementation is complete:
```
Implementation complete!

✅ All phases implemented successfully
✅ Automated verification passing
📋 Manual verification needed for:
  - [List items requiring human testing]

The plan has been updated with all completed checkmarks.
```

## Error Recovery

If verification fails:
1. Read the error messages carefully
2. Fix issues in the current phase
3. Re-run verification
4. Only proceed when all checks pass

If you can't resolve an issue:
```
Blocked in Phase [N]:
Error: [specific error message]
Attempted fixes:
- [What you tried]
- [Why it didn't work]

Need guidance on how to proceed.
```

## Remember

You're implementing a solution, not just checking boxes. Keep the end goal in mind, maintain code quality, and ensure each phase builds properly on the previous ones. The plan is your guide, but your judgment matters when adapting to reality.