def insertion_sort_right_to_left(arr):
    # Iterate from the second-to-last element to the beginning of the array
    for i in range(len(arr) - 2, -1, -1):
        key = arr[i]
        j = i + 1
        # Move elements of arr[j] that are greater than key, to one position ahead
        # of their current position
        while j < len(arr) and arr[j] < key:
            arr[j - 1] = arr[j]
            j += 1
        arr[j - 1] = key
    return arr

# Example usage
arr = [4, 3, 2, 10, 12, 1, 5, 6]
sorted_arr = insertion_sort_right_to_left(arr)
print(sorted_arr)
