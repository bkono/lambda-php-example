#!/usr/bin/env sh

echo "starting build..."
# rm /out/app.zip >/dev/null 2>&1
echo "... skipping rm"
echo "... attempting copy..."
cp /app/app.zip /out/
echo "... copy complete. all done!"
