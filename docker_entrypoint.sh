#!/usr/bin/env sh

echo "starting build..."
echo "... rm the old stuff"
rm /out/app.zip >/dev/null 2>&1
echo "... attempting copy"
cp /app/app.zip /out/
echo "... copy complete."
ls -al /out/
echo "... all done!"
