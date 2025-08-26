#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import argparse
sys.path.insert(0, '/www/server/panel')

from BTPanel import app
import public, panelSite

def add_site(domain, phpv, port=80, ps=None):
    """调用 panelSite.AddSite 创建站点"""
    if ps is None:
        ps = domain.replace('.', '_')

    with app.test_request_context('/'):
        args = public.dict_obj()
        args.webname = '{"domain":"%s","domainlist":[],"count":0}' % domain
        args.port = str(port)
        args.type = "PHP"
        args.ps = ps
        args.path = "/www/wwwroot/%s" % domain
        args.ftp = "false"
        args.sql = "false"
        args.codeing = "utf8"
        args.version = str(phpv)
        args.type_id = "0"
        args.set_ssl = "0"
        args.force_ssl = "0"
        args.is_create_default_file = "true"

        site_obj = panelSite.panelSite()
        result = site_obj.AddSite(args)
        return result

def main():
    parser = argparse.ArgumentParser(description="一键建站工具 (aaPanel/宝塔国际版)")
    parser.add_argument("-d", "--domain", required=True, help="要创建的域名")
    parser.add_argument("-p", "--php", default="74", help="PHP版本，如74、80")
    parser.add_argument("--port", default=80, type=int, help="站点端口，默认80")
    parser.add_argument("--ps", default=None, help="备注，默认域名替换下划线")
    args = parser.parse_args()

    res = add_site(args.domain, args.php, args.port, args.ps)
    print("建站结果：")
    print(res)

if __name__ == "__main__":
    main()
