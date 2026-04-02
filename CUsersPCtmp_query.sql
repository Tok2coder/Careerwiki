SELECT id, name, user_contributed_json, merged_profile_json FROM jobs WHERE is_active = 1 AND merged_profile_json LIKE '%"way"%' ORDER BY name LIMIT 20 OFFSET 0
