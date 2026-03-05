#!/usr/bin/env python3
"""Phase 3 Steps 3-3~3-6: Extract 4 route files from src/index.tsx"""

import os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INDEX = os.path.join(BASE, "src", "index.tsx")
ROUTES = os.path.join(BASE, "src", "routes")

with open(INDEX, "r", encoding="utf-8") as f:
    lines = f.readlines()

def extract(start, end):
    """Extract lines[start-1:end] (1-indexed inclusive)"""
    return "".join(lines[start-1:end])

# ============================================================
# 1) pages.ts
# ============================================================
pages_header = """import { Hono } from 'hono'
import { getCookie, deleteCookie } from 'hono/cookie'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  renderUserMenu, getLogoSVG, getOptionalUser,
  renderLayout, renderLayoutWithContext, escapeHtml,
  buildCanonicalUrl, parseSourcesQuery, parseNumberParam
} from '../utils/shared-helpers'
import { renderOnboardingPage } from '../templates/onboarding'
import { renderTermsPage } from '../templates/legal/terms'
import { renderPrivacyPage } from '../templates/legal/privacy'
import { renderHelpPage } from '../templates/help'
import { renderNav, renderNavStyles, renderNavScripts } from '../templates/partials/nav'
import {
  getOnboardingStatus,
  checkNicknameAvailability,
  submitOnboarding,
} from '../services/onboardingService'
import { buildCommentGovernanceItems, resolveCommentPolicy } from '../templates/detailTemplateUtils'
import { renderJobTemplateDesignPage } from '../templates/jobTemplateDesignPage'
import { renderJobETLInspectionPage } from '../templates/jobETLInspectionPage'
import { composeDetailSlug, resolveDetailIdFromSlug } from '../utils/slug'
import { getUnifiedJobDetailWithRawData, getUnifiedMajorDetail, searchUnifiedJobs, searchUnifiedMajors } from '../services/profileDataService'
import type { D1Database } from '@cloudflare/workers-types'
import type { JobSourceRow, MajorSourceRow } from '../types/database'
import type { UnifiedJobDetail, UnifiedMajorDetail } from '../types/unifiedProfiles'

export const pagesRoutes = new Hono<AppEnv>()

"""

# L182-206: debug/bindings
pages_debug = extract(181, 206)  # "// 임시 진단..." line 181 is blank, start at 182
pages_debug = extract(182, 206)

# L271-351: onboarding routes (skip inline import at L269)
pages_onboarding = extract(271, 351)

# L354-367: legal/terms, legal/privacy
pages_legal = extract(354, 367)

# L370-375: help
pages_help = extract(370, 375)

# L379-568: releases
pages_releases = extract(378, 568)  # include comment line above

# L572-632: homepage
pages_homepage = extract(571, 632)  # include comment line

# L635-724: analyzer
pages_analyzer = extract(634, 724)

# L15771-15878: community-guidelines
pages_community = extract(15770, 15878)

# L15881-16448: template design pages
pages_templates = extract(15880, 16448)

# L16451-16560: login
pages_login = extract(16450, 16560)

# L16563-16566: redirects
pages_redirects = extract(16562, 16566)

# L20525-20599: robots.txt, sitemap.xml
pages_seo = extract(20524, 20599)

# L291-303: /api/me/onboarding
pages_onboarding_api = extract(290, 303)

# L306-319: /api/nickname/check
pages_nickname = extract(305, 319)

# Replace 'app.' with 'pagesRoutes.'
pages_body = (
    pages_debug + "\n" +
    pages_onboarding + "\n" +
    pages_onboarding_api + "\n" +
    pages_nickname + "\n" +
    pages_legal + "\n" +
    pages_help + "\n" +
    pages_releases + "\n" +
    pages_homepage + "\n" +
    pages_analyzer + "\n" +
    pages_community + "\n" +
    pages_templates + "\n" +
    pages_login + "\n" +
    pages_redirects + "\n" +
    pages_seo
)
pages_body = pages_body.replace("app.get(", "pagesRoutes.get(")
pages_body = pages_body.replace("app.post(", "pagesRoutes.post(")

pages_content = pages_header + pages_body

with open(os.path.join(ROUTES, "pages.ts"), "w", encoding="utf-8") as f:
    f.write(pages_content)
print(f"pages.ts: {pages_content.count(chr(10))+1} lines")


# ============================================================
# 2) user.ts
# ============================================================
user_header = """import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  renderUserMenu, renderLayoutWithContext, escapeHtml,
  getOptionalUser, formatDateSafe, parseNumberParam
} from '../utils/shared-helpers'
import { renderUserLayoutContent } from '../templates/user/userLayout'
import { renderUserAiResultsContent, type AiResultItem } from '../templates/user/userAiResults'
import { renderSecurityPage } from '../templates/user/userSecurity'
import {
  listUserSessions, destroySession,
  destroyAllUserSessions, getUserSessionEntries
} from '../utils/session'

export const userRoutes = new Hono<AppEnv>()

"""

# L16570-16793: /user/drafts
user_drafts = extract(16569, 16793)

# L18424-18426: /user redirect
user_redirect1 = extract(18423, 18426)

# L18431-18433: /user/profile redirect
user_redirect2 = extract(18428, 18433)

# L18438-19305: generateProfileContentHtml function
user_profile_fn = extract(18435, 19305)

# L19308-19641: /user/ai-results
user_ai_results = extract(19308, 19641)

# L19644-19781: /user/comments
user_comments = extract(19644, 19781)

# L19783-19916: /user/bookmarks (check end)
user_bookmarks = extract(19783, 19916)

# L19918-19990: /api/bookmark routes
user_bookmark_api = extract(19918, 19990)

# L19991-20095: /api/user/profile-image
user_profile_image = extract(19991, 20095)

# L20100-20168: /api/user/sessions (skip inline import at L20097 - moved to header)
user_sessions = extract(20100, 20168)

# L20171-20515: /user/settings
user_settings = extract(20171, 20515)

# L20521: /user/security redirect (skip inline import at L20518 - moved to header)
user_security = extract(20520, 20521)

user_body = (
    user_drafts + "\n" +
    user_redirect1 + "\n" +
    user_redirect2 + "\n" +
    user_profile_fn + "\n" +
    user_ai_results + "\n" +
    user_comments + "\n" +
    user_bookmarks + "\n" +
    user_bookmark_api + "\n" +
    user_profile_image + "\n" +
    user_sessions + "\n" +
    user_settings + "\n" +
    user_security
)
user_body = user_body.replace("app.get(", "userRoutes.get(")
user_body = user_body.replace("app.post(", "userRoutes.post(")
user_body = user_body.replace("app.delete(", "userRoutes.delete(")

user_content = user_header + user_body

with open(os.path.join(ROUTES, "user.ts"), "w", encoding="utf-8") as f:
    f.write(user_content)
print(f"user.ts: {user_content.count(chr(10))+1} lines")


# ============================================================
# 3) api-data.ts
# ============================================================
api_data_header = """import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import {
  parseSourcesQuery, parseNumberParam, escapeHtml
} from '../utils/shared-helpers'
import { weakETag, toNFC, matchETag } from '../utils/etag'
import { TEMPLATE_VERSIONS } from '../constants/template-versions'
import { searchUnifiedJobs, searchUnifiedMajors, getUnifiedJobDetail, getUnifiedJobDetailWithRawData, getUnifiedMajorDetail } from '../services/profileDataService'
import { ragSearchJobs, ragSearchMajors } from '../services/rag-search'
import { JOB_CATEGORIES } from '../api/careernetAPI'
import { renderJobCard, renderMajorCard } from '../utils/card-renderers'
import type { UnifiedJobDetail, UnifiedMajorDetail } from '../types/unifiedProfiles'
import type { JobSourceRow, MajorSourceRow } from '../types/database'

export const apiDataRoutes = new Hono<AppEnv>()

"""

# L17259-17310: /api/majors
api_data_majors = extract(17258, 17310)

# L17313-17340: /api/majors/search
api_data_majors_search = extract(17312, 17340)

# L17343-17391: /api/majors/:id
api_data_majors_id = extract(17342, 17391)

# L17394-17449: /api/jobs
api_data_jobs = extract(17393, 17449)

# L17452-17482: /api/jobs/search
api_data_jobs_search = extract(17451, 17482)

# Now read jobs/:id through major/:id/edit-data
# L17485-17522: /api/jobs/:id
api_data_jobs_id = extract(17484, 17522)

# L17525-17858: /api/job/:id/edit-data
api_data_job_edit = extract(17524, 17858)

# L17862-18275: /api/major/:id/edit-data
api_data_major_edit = extract(17861, 18275)

# L18277-18288: /api/categories
api_data_categories = extract(18277, 18288)

# L18290-18313: /api/job/cards
api_data_job_cards = extract(18290, 18313)

# L18315-18342: /api/major/cards
api_data_major_cards = extract(18315, 18342)

# NOTE: L18344-18375 (duplicate /api/majors) and L18377-18416 (duplicate /api/majors/:id) — SKIP

api_data_body = (
    api_data_majors + "\n" +
    api_data_majors_search + "\n" +
    api_data_majors_id + "\n" +
    api_data_jobs + "\n" +
    api_data_jobs_search + "\n" +
    api_data_jobs_id + "\n" +
    api_data_job_edit + "\n" +
    api_data_major_edit + "\n" +
    api_data_categories + "\n" +
    api_data_job_cards + "\n" +
    api_data_major_cards
)
api_data_body = api_data_body.replace("app.get(", "apiDataRoutes.get(")
api_data_body = api_data_body.replace("app.post(", "apiDataRoutes.post(")

api_data_content = api_data_header + api_data_body

with open(os.path.join(ROUTES, "api-data.ts"), "w", encoding="utf-8") as f:
    f.write(api_data_content)
print(f"api-data.ts: {api_data_content.count(chr(10))+1} lines")


# ============================================================
# 4) api-misc.ts
# ============================================================
api_misc_header = """import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import {
  isAnalysisType, isPricingTier, isRequestStatus,
  parseNumberParam, getClientIp, toIntegerOrNull, hashIpAddress
} from '../utils/shared-helpers'
import { storePerfMetrics, type PerfMetricsPayload, type PerfAlert } from '../services/perfMetricsService'
import {
  createOrUpdateSession,
  createAnalysisRequest,
  createAnalysisResult,
  getAnalysisRequestWithResult,
  getSession as getAiSession,
  listRequestsBySession,
  updateRequestStatus
} from '../services/aiAnalysisService'
import {
  recordSerpInteraction,
  getDailySerpSummary,
  listRecentSerpInteractions
} from '../services/serpInteractionService'
import { attemptScheduledRefresh, getFreshnessStatus, resolveFreshnessTargetById } from '../services/freshnessService'

export const apiMiscRoutes = new Hono<AppEnv>()

"""

# L16801-16841: helper functions
api_misc_helpers = extract(16801, 16841)

# L16846-16862: /api/me
api_misc_me = extract(16845, 16862)

# L16864-16913: /api/perf-metrics (first, keep this one)
api_misc_perf = extract(16863, 16913)

# NOTE: L16915-16937 is DUPLICATE /api/perf-metrics — SKIP

# L16939-16993: /api/analyzer/sessions
api_misc_analyzer1 = extract(16939, 16993)

# L16994-17041: /api/analyzer/requests POST
api_misc_analyzer2 = extract(16994, 17041)

# L17042-17055: /api/analyzer/requests/:id GET
api_misc_analyzer3 = extract(17042, 17055)

# L17056-17101: /api/analyzer/requests/:id/result POST
api_misc_analyzer4 = extract(17056, 17101)

# L17103-17138: /api/analyzer/requests/:id/status POST + sessions/:id/requests
api_misc_analyzer5 = extract(17103, 17138)

# L17140-17199: /api/serp-interactions
api_misc_serp = extract(17140, 17199)

# L17201-17256: /api/freshness/*
api_misc_freshness = extract(17201, 17256)

# L16910-16913: /api/client-ip
api_misc_client_ip = extract(16909, 16913)

api_misc_body = (
    api_misc_helpers + "\n" +
    api_misc_me + "\n" +
    api_misc_perf + "\n" +
    api_misc_client_ip + "\n" +
    api_misc_analyzer1 + "\n" +
    api_misc_analyzer2 + "\n" +
    api_misc_analyzer3 + "\n" +
    api_misc_analyzer4 + "\n" +
    api_misc_analyzer5 + "\n" +
    api_misc_serp + "\n" +
    api_misc_freshness
)
api_misc_body = api_misc_body.replace("app.get(", "apiMiscRoutes.get(")
api_misc_body = api_misc_body.replace("app.post(", "apiMiscRoutes.post(")

api_misc_content = api_misc_header + api_misc_body

with open(os.path.join(ROUTES, "api-misc.ts"), "w", encoding="utf-8") as f:
    f.write(api_misc_content)
print(f"api-misc.ts: {api_misc_content.count(chr(10))+1} lines")


# ============================================================
# 5) Delete extracted ranges from index.tsx (bottom-up)
# ============================================================
# Ranges to delete (1-indexed, inclusive), sorted desc by start line
# We delete bottom-up to preserve line numbers

delete_ranges = [
    # robots.txt + sitemap.xml
    (20524, 20599),
    # /user/security redirect + inline import
    (20517, 20521),
    # /user/settings
    (20171, 20515),
    # /api/user/sessions + inline import at L20097
    (20097, 20168),
    # /api/user/profile-image
    (19991, 20095),
    # /api/bookmark
    (19918, 19990),
    # /user/bookmarks
    (19783, 19916),
    # /user/comments
    (19644, 19781),
    # /user/ai-results + /user/ai-results/:requestId
    (19308, 19641),
    # generateProfileContentHtml + /user/profile redirect + /user redirect + comments above
    (18418, 19305),
    # Duplicate /api/majors + /api/majors/:id (L18344-18416) + blank lines
    (18340, 18416),
    # /api/major/cards
    (18315, 18342),
    # /api/job/cards
    (18290, 18313),
    # /api/categories
    (18277, 18288),
    # /api/major/:id/edit-data
    (17861, 18275),
    # /api/job/:id/edit-data
    (17524, 17858),
    # /api/jobs/:id
    (17484, 17522),
    # /api/jobs/search
    (17451, 17482),
    # /api/jobs
    (17393, 17449),
    # /api/majors/:id
    (17342, 17391),
    # /api/majors/search
    (17312, 17340),
    # /api/majors
    (17258, 17310),
    # /api/freshness/*
    (17201, 17256),
    # /api/serp-interactions
    (17140, 17199),
    # /api/analyzer/* routes
    (16939, 17138),
    # duplicate /api/perf-metrics
    (16915, 16937),
    # /api/client-ip
    (16909, 16913),
    # /api/perf-metrics (first definition)
    (16863, 16908),
    # /api/me
    (16845, 16862),
    # formatPerfAlertLine + sendPerfAlertsToSlack (+ blank lines before)
    (16795, 16841),
    # /user/drafts
    (16569, 16793),
    # /terms redirect + /privacy redirect
    (16562, 16567),
    # /login
    (16450, 16560),
    # template design pages
    (15880, 16448),
    # community-guidelines
    (15770, 15878),
    # /analyzer page
    (634, 724),
    # homepage
    (570, 632),
    # /releases
    (377, 568),
    # /help
    (369, 375),
    # /legal/terms + /legal/privacy
    (353, 367),
    # /api/nickname/check
    (305, 319),
    # /api/me/onboarding
    (290, 303),
    # /onboarding + inline import of getCookie/deleteCookie
    (264, 288),
    # /api/debug/bindings + comment above
    (181, 206),
]

# Sort descending by start
delete_ranges.sort(key=lambda r: r[0], reverse=True)

for start, end in delete_ranges:
    # Convert to 0-indexed
    del lines[start-1:end]

with open(INDEX, "w", encoding="utf-8") as f:
    f.writelines(lines)

remaining = len(lines)
print(f"index.tsx: {remaining} lines remaining after deletions")
print("Done!")
