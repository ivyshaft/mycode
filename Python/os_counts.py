def os_counts(os_dict):
    os_list = list(os_dict.values())
    os_set = set(os_list)
    os_keys = list(os_set)
    os_keys.sort(reverse=True)
    output_dict = {}
    for os in os_keys:
        os_count = os_list.count(os)
        output_dict[os] = os_count
    return output_dict
    

user_laptop_os = {"user1": "Windows10", "user2": "Windows10", "user3": "Chrome OS", "user4": "Windows11", "user5": "Windows11", "user6": "Ubuntu", "user7": "MacOS", "user8": "Windows11", "user9": "MacOS", "user10": "Ubuntu", "user11": "Chrome OS", "user12": "Windows XP", "user13": "Windows XP", "user14": "DOS", "user15": "Ubuntu", "user16": "Windows11", "user17": "Chrome OS"}

print(os_counts(user_laptop_os))
