def merge_sort(arr, depth=0):
    if len(arr) <= 1:
        return arr

    # 找到中间点，分成两半
    mid = len(arr) // 2
    left_half = arr[:mid]
    right_half = arr[mid:]

    # 打印当前分割的数组
    print(f"{'  ' * depth}Split: {arr} -> {left_half} and {right_half}")

    # 对每一半进行归并排序
    left_sorted = merge_sort(left_half, depth + 1)
    right_sorted = merge_sort(right_half, depth + 1)

    # 合并两个已排序的子数组
    merged = merge(left_sorted, right_sorted, depth + 1)

    # 打印合并后的数组
    print(f"{'  ' * depth}Merged: {merged}")

    return merged

def merge(left, right, depth):
    merged = []
    left_index = 0
    right_index = 0

    # 合并两个子数组，直到其中一个耗尽
    while left_index < len(left) and right_index < len(right):
        if left[left_index] < right[right_index]:
            merged.append(left[left_index])
            left_index += 1
        else:
            merged.append(right[right_index])
            right_index += 1

    # 如果左子数组还有剩余元素，添加到合并结果
    while left_index < len(left):
        merged.append(left[left_index])
        left_index += 1

    # 如果右子数组还有剩余元素，添加到合并结果
    while right_index < len(right):
        merged.append(right[right_index])
        right_index += 1

    return merged

# 测试归并排序
arr = [5, 2, 9, 1, 5, 6,7]
print("Original array:", arr)
sorted_arr = merge_sort(arr)
print("Sorted array:", sorted_arr)
