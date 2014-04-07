import sys

cols = []
for arg in sys.argv[1:]:
    cols.append(arg.split("=>"))


lines = open('../results/timings').read().split("\n")
headers = lines[0].split()
nums = [0] * len(headers)
means = [0] * len(headers)
variance = [0] * len(headers)
data = lines[1:]

if cols[0][0] == "--all":
    print " ".join(headers)
    sys.exit(0)

for n, line in enumerate(data):
    for i, v in enumerate(line.split()):
        nums[i] += 1

for n, line in enumerate(data):
    for i, v in enumerate(line.split()):
        means[i] += float(v)/nums[i]


for n, line in enumerate(data):
    for i, v in enumerate(line.split()):
        variance[i] += (float(v) - means[i])**2/nums[i]

revheaders = {}
for i, h in enumerate(headers):
    revheaders[h] = i

for h,name in cols:
    i = revheaders[h]
    if len(name.split()) > 1:
        print("\"%s\"\t%f\t%f" % (name, means[i]/1E9, variance[i]**.5/1E9));
    else:
        print("%s\t%f\t%f" % (name, means[i]/1E9, variance[i]**.5/1E9));
