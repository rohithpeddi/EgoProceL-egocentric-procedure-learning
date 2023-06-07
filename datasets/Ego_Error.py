"""
This file contains data loader for the CMU Kitchens dataset
"""

import os

import torch

from folder_utils.file_utils import (
	get_category_metadata,
	_extract_frames_h5py,
	_sample_frames_gen_labels_h5py
)
import folder_utils.logger as logging

logger = logging.get_logger(__name__)


class Ego_Error(torch.utils.data.Dataset):
	"""
    CMU Kitchens loader
    """
	
	def __init__(self, cfg, mode='all', transforms=None):
		# Loading necessary paths and data
		self.cfg = cfg
		self.mode = mode
		self.transforms = transforms
		assert mode in ['train', 'val', 'test', 'all'], ('Wrong mode selected'
		                                                 '. Options are: train, val, test, all')
		videos_dir = self.cfg.EGO_ERROR.VIDEOS_PATH
		annotations_dir = self.cfg.EGO_ERROR.ANNS_PATH
		assert os.path.isdir(videos_dir), 'Wrong videos path provided!'
		assert os.path.isdir(annotations_dir), ('Wrong annotations path '
		                                        'provided!')
		self.category = self.cfg.ANNOTATION.CATEGORY
		if self.cfg.MISC.VERBOSE:
			logger.debug('Processing category: {}'.format(self.category))
		videos_path = os.path.join(videos_dir, self.category)
		anns_path = os.path.join(annotations_dir, self.category)
		self.videos = [
			os.path.join(videos_path, file) for file in os.listdir(videos_path)
		]
		self.annotations = [
			os.path.join(anns_path, file) for file in os.listdir(anns_path)
		]
		assert len(self.videos) == len(self.annotations), 'Trahimaam!'
		
		if self.mode == 'all':
			# No need to trim the videos and annotations list
			pass
		elif self.mode == 'train':
			raise NotImplementedError
		elif self.mode == 'val':
			raise NotImplementedError
		elif self.mode == 'test':
			raise NotImplementedError
		
		self._construct_loader()
	
	def _construct_loader(self):
		"""
        This method constructs the video and annotation loader

        Returns:
            None
        """
		self.package = list()
		# Sorting the videos based on subject number
		self.videos = sorted(
			self.videos, key=lambda a: a.split('/')[-1].split('_')[0]
		)
		for video in self.videos:
			video_name = video.split('/')[-1].split('.')[0]
			if '_360p' in video_name:
				video_name = video_name[:-5]
			for annotation in self.annotations:
				if video_name in annotation:
					self.package.append((video, annotation))
					break
		assert len(self.package) == len(self.videos) == len(self.annotations)
	
	def __len__(self):
		"""
        Returns:
            (int): number of videos and annotations in the dataset
        """
		return len(self.package)
	
	def __getitem__(self, index):
		video_path, annotation_path = self.package[index]
		h5_file_path = _extract_frames_h5py(
			video_path,
			self.cfg.EGO_ERROR.FRAMES_PATH
		)
		frames, labels = _sample_frames_gen_labels_h5py(
			self.cfg,
			h5_file_path,
			video_path,
			annotation_path,
			transforms=self.transforms
		)
		return frames, labels, video_path.split('/')[-1].split('.')[0]
