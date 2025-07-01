def is_valid_ipv4(ip_address):
    valid = True
    num_chars = []
    numbers = list(range(10))
    for num in numbers:
        num_chars += str(num)
    if type(ip_address) != str:
        valid = False
        return valid#, "Entry provided not a string."
    if "." not in ip_address:
        valid = False
        return valid#, "Entry provided did not have period separators."
    split = ip_address.split(".")
    if len(split) != 4:
        valid = False
        return valid#, "Entry did not have 4 octects/groups of characters."
    for quad in split:
        for char in quad:
            if char not in num_chars:
                valid = False
                return valid#, "Entry has some non-numerical characters"
        number = int(quad)
        if not 0 <= number <= 255:
            valid = False
            return valid#, "Entry has out-of range numerical octects."
    return valid#, "Valid IPv4 Address!"

# valid
print(is_valid_ipv4("172.16.01.3"))

# not valid
print(is_valid_ipv4("255.123.323.0"))

# not valid
print(is_valid_ipv4("255,123,323,0"))

# not valid
print(is_valid_ipv4("192.168.0"))

# not valid
print(is_valid_ipv4("235.123.0.a38"))

# not valid
print(is_valid_ipv4(235.123))

# valid
print(is_valid_ipv4("10.0.0.1"))
