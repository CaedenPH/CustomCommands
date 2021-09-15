import os, sys

query = sys.argv[1]
opts = " ".join(sys.argv[2:])

for k in sys.argv:
    if k.startswith('ignore'):
        ignore=k[7:]


output = []
for root, dirs, files in os.walk("/"):
    if not 'directory' in opts:
        for filename in files:
            if query == filename:
                output.append(f"{root}/{filename}") 

    if not 'file' in opts:
        for directory in dirs:
            #print(root, ignore)
            if globals().get('ignore') and ignore in root:
                continue
            if directory == query:
                output.append(f"{root}/{directory}")

print(f"Results for {query} {f'with ignore of {ignore}' if globals().get('ignore') else ''}:", str(['\n'.join(output)]).replace('\'', '').replace('[', '').replace(']', '') if output else f"No {', '.join(opts.split(' '))} found for {query}")

