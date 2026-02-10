# Cloudflare Community Post - D1 Export Stuck Issue

## What is this discussion about in one brief sentence?
D1 database export operation has been stuck for over 11 hours, blocking all database access including queries and API calls.

## For Workers & Pages, what is the name of the domain?
N/A (D1 Database issue, not domain-related)

## What is the error number?
**7500**

## What is the error message?
```
Currently processing a long-running export. [code: 7500]
```

Additional error messages:
```
internal error; reference = e_PVSMDp_401b622161f54faabff7d3631b379957 [code: 7500]
```

```
internal error; reference = e_PVSMDp_7332ace4975c4f7e825efe439e3a12ca [code: 7500]
```

## What is the issue or error you're encountering?

A D1 database export operation started approximately 11 hours ago and has become stuck, preventing all database access. The database cannot execute queries, retrieve information, or start new export operations. The Cloudflare Dashboard does not show any export progress or cancellation options.

**Environment:**
- Wrangler Version: 4.57.0
- D1 Database: `careerwiki-kr`
- Database ID: `edc21e23-c2ac-4693-bb79-389b6914e173`
- Database Size: ~299 MB (313,769,984 bytes)

**Symptoms:**
1. All query executions return error code 7500: "Currently processing a long-running export"
2. Export API calls are blocked with the same error
3. Database info retrieval fails with "internal error"
4. No export progress or cancel option visible in Cloudflare Dashboard
5. Database appears in list but detail page may show errors

**Impact:**
Production database is completely inaccessible, causing service disruption.

## What steps have you taken to resolve the issue?

1. ✅ Terminated local terminal processes (no effect - server-side operation)
2. ✅ Waited for export completion (over 11 hours elapsed, still stuck)
3. ✅ Logged out and logged back into wrangler (no effect)
4. ❌ Attempted to cancel via Cloudflare Dashboard (no export UI visible)
5. ❌ Attempted to start new export (blocked: "Cannot start a new export until that completes or times out")

## What are the steps to reproduce the issue?

1. Start an export operation on a large D1 database (~300MB) using:
   ```bash
   npx wrangler d1 export careerwiki-kr --remote --output=export.sql
   ```
   Or via API:
   ```bash
   POST /accounts/{account_id}/d1/database/{database_id}/export
   ```

2. Export operation begins in background

3. Export does not complete and becomes stuck

4. All subsequent database operations are blocked:
   - Query execution: `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT 1"`
   - Database info: `npx wrangler d1 info careerwiki-kr`
   - New exports: Cannot start until stuck export completes

## Screenshot of the error

**Query Execution Error:**
```json
{
  "error": {
    "text": "A request to the Cloudflare API (/accounts/3587865378649966bfb0a814fce73c77/d1/database/edc21e23-c2ac-4693-bb79-389b6914e173/query) failed.",
    "notes": [
      {
        "text": "Currently processing a long-running export. [code: 7500]"
      }
    ],
    "kind": "error",
    "name": "APIError",
    "code": 7500,
    "accountTag": "3587865378649966bfb0a814fce73c77"
  }
}
```

**Export API Response:**
```json
{
  "result": {
    "success": false,
    "error": "Currently processing a long-running export. Cannot start a new export until that completes or times out."
  },
  "success": true,
  "messages": [],
  "errors": []
}
```

**Database Info Error:**
```
internal error; reference = e_PVSMDp_7332ace4975c4f7e825efe439e3a12ca [code: 7500]
```

---

**Additional Information:**
- Error Reference Codes: `e_PVSMDp_401b622161f54faabff7d3631b379957`, `e_PVSMDp_7332ace4975c4f7e825efe439e3a12ca`
- Issue Started: 2026-01-13 12:37 (KST)
- Current Status: Still ongoing (11+ hours)
- Account ID: `3587865378649966bfb0a814fce73c77`
