import fnmatch
import shutil
import os

def copy_directory_excluding(src_dir, dest_dir, exclude=None):
	"""
	Copy a directory to another location, excluding specified files or directories.

	:param src_dir: Source directory path
	:param dest_dir: Destination directory path
	:param exclude: List of filenames or directory names to exclude
	"""
	if exclude is None:
		exclude = []

	def ignore_patterns(path, names):
		ignored_names = set()
		print("check path: " + path)
		for pattern in exclude:
			if pattern.lower() in [n.lower() for n in names]:
				print("excluded by name:" + pattern)
				ignored_names.add(pattern)
			for flt in fnmatch.filter(names, pattern):
				if flt not in ignored_names:
					print("excluded by glob pattern:" + flt)
					ignored_names.add(flt)
		return ignored_names

	if not os.path.exists(dest_dir):
		os.makedirs(dest_dir)

	shutil.copytree(src_dir, dest_dir, ignore=ignore_patterns,dirs_exist_ok=True)

# Example usage:
# copy_directory_excluding('path/to/source', 'path/to/destination', exclude=['exclude_dir', 'exclude_file.txt'])