#!/usr/bin/env python3
"""Generates lib/l10n/arb/app_en.arb and app_tr.arb from the Python sources.

Usage: python3 tool/l10n/gen_arb.py
To add a new language later you can simply copy lib/l10n/arb/app_en.arb to
app_<code>.arb and translate it by hand – this script is only a convenience
for keeping EN/TR in sync.
"""
import json, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from ui_text import UI
from exercises_text import EX

root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
out = os.path.join(root, 'lib', 'l10n', 'arb')
os.makedirs(out, exist_ok=True)

for idx, lang in enumerate(['en', 'tr']):
    d = {'@@locale': lang}
    for key, val in UI.items():
        d[key] = val[idx]
        if lang == 'en' and len(val) > 2:
            d['@' + key] = {'placeholders': {p: {'type': t} for p, t in val[2].items()}}
    for ex_id, (en, tr) in EX.items():
        src = en if idx == 0 else tr
        for field, text in zip(['Name', 'Summary', 'Steps', 'Tip'], src):
            d['ex%s%s' % (ex_id, field)] = text
    with open(os.path.join(out, 'app_%s.arb' % lang), 'w', encoding='utf-8') as f:
        json.dump(d, f, ensure_ascii=False, indent=2)
        f.write('\n')
    print(lang, len(d) - 1, 'entries')
