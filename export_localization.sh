#!/bin/bash

if [[ $(git diff --name-only HEAD~1 HEAD | grep Base.lproj/Localizable.strings) ]]
then
curl -X POST https://api.poeditor.com/v2/projects/upload \
       -F api_token="c2c2bc2c2f5c707a86fa068460bdc934" \
       -F id="212093" \
       -F updating="terms_translations" \
       -F file=@"Localization/Resources/Strings/Base.lproj/Localizable.strings" \
       -F language="en"
fi