emails = ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]

uniques = set()
for mail in emails:
    local,domain = mail.split('@')
    local = local.split('+')[0]
    local = local.replace('.','')
    email = local + '@' + domain
    uniques.add(email)
print(len(uniques))