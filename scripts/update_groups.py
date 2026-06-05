#!/usr/bin/env python3
"""Actualiza los grupos de los 42 usuarios del workshop"""
import xmlrpc.client
import time

common = xmlrpc.client.ServerProxy("http://localhost:8069/xmlrpc/2/common")
models = xmlrpc.client.ServerProxy("http://localhost:8069/xmlrpc/2/object")
uid = common.authenticate("odoo_workshop", "admin", "admin", {})

def get_group_id(xml_id):
    parts = xml_id.split(".")
    module, name = parts
    result = models.execute_kw("odoo_workshop", uid, "admin", "ir.model.data", "search_read",
        [[["module", "=", module], ["name", "=", name]]],
        {"fields": ["res_id"], "limit": 1})
    return result[0]["res_id"] if result else None

group_map = {
    1: ["sales_team.group_sale_salesman", "base.group_user"],
    2: ["purchase.group_purchase_user", "stock.group_stock_user", "base.group_user"],
    3: ["mrp.group_mrp_user", "stock.group_stock_user", "base.group_user"],
    4: ["account.group_account_user", "base.group_user"],
    5: ["hr.group_hr_user", "project.group_project_user", "base.group_user"],
}

print("Grupos disponibles:")
desired = {}
for g, xml_ids in group_map.items():
    for xml_id in xml_ids:
        if xml_id not in desired:
            desired[xml_id] = get_group_id(xml_id)
        status = "✅" if desired[xml_id] else "❌"
        print(f"  {status} {xml_id}: ID {desired[xml_id]}")

print("\nActualizando usuarios...")
updated = 0
for g in range(1, 6):
    users = models.execute_kw("odoo_workshop", uid, "admin", "res.users", "search_read",
        [[["login", "=like", f"g{g}_%"]]], {"fields": ["id", "login", "name"]})
    for user in users:
        gids = [gid for xml_id in group_map[g] if (gid := desired.get(xml_id))]
        if gids:
            models.execute_kw("odoo_workshop", uid, "admin", "res.users", "write",
                [[user["id"]], {"group_ids": [(6, 0, gids)]}])
            print(f"  ✅ {user['login']:<25} -> {user['name']}")
            updated += 1
            time.sleep(0.1)

print(f"\n✅ {updated} usuarios actualizados")
