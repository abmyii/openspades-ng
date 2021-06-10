/*
 Copyright (c) 2013 yvt
 
 This file is part of OpenSpades.
 
 OpenSpades is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 OpenSpades is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with OpenSpades.  If not, see <http://www.gnu.org/licenses/>.
 
 */
 
 namespace spades {
	class ThirdPersonPistolSkin: 
	IToolSkin, IThirdPersonToolSkin, IWeaponSkin {
		private float sprintState;
		private float raiseState;
		private Vector3 teamColor;
		private bool muted = true;
		private Matrix4 originMatrix;
		private float aimDownSightState;
		private float readyState;
		private bool reloading;
		private float reloadProgress;
		private int ammo, clipSize;
		
		float SprintState { 
			set { sprintState = value; }
		}
		
		float RaiseState { 
			set { raiseState = value; }
		}
		
		bool IsMuted {
			set { muted = value; }
		}
		
		Vector3 TeamColor { 
			set { teamColor = value; } 
		}
		
		Matrix4 OriginMatrix {
			set { originMatrix = value; }
		}
		
		float PitchBias {
			get { return 0.f; }
		}
		
		float AimDownSightState {
			set { aimDownSightState = value; }
		}
		
		bool IsReloading {
			set { reloading = value; }
		}
		float ReloadProgress {
			set { reloadProgress = value; }
		}
		int Ammo {
			set { ammo = value; }
		}
		int ClipSize {
			set { clipSize = value; }
		}
		
		float ReadyState {
			set { readyState = value; }
		}
		
		private Renderer@ renderer;
		private AudioDevice@ audioDevice;
		private Model@ model;
		private AudioChunk@ fireSound;
		private AudioChunk@ reloadSound;
		
		ThirdPersonPistolSkin(Renderer@ r, AudioDevice@ dev) {
			@renderer = r;
			@audioDevice = dev;
			@model = renderer.RegisterModel
				("Models/Weapons/Pistol/Weapon.kv6");
			
			@fireSound = dev.RegisterSound
				("Sounds/Weapons/Pistol/Fire.wav");
			@reloadSound = dev.RegisterSound
				("Sounds/Weapons/Pistol/Reload.wav");
		}
		
		void Update(float dt) {
		}
		
		void WeaponFired(){
			if(!muted){
				Vector3 origin = originMatrix * Vector3(0.f, 0.f, 0.f);
				AudioParam param;
				param.volume = 8.f;
				audioDevice.Play(fireSound, origin, param);
			}
		}
		
		void ReloadingWeapon() {
			if(!muted){
				Vector3 origin = originMatrix * Vector3(0.f, 0.f, 0.f);
				AudioParam param;
				param.volume = 0.2f;
				audioDevice.Play(reloadSound, origin, param);
			}
		}
		
		void ReloadedWeapon() {
		}
		
		void AddToScene() {
			Matrix4 mat = CreateScaleMatrix(0.007f);
			mat = mat * CreateScaleMatrix(-1.f, -1.f, 1.f);
			mat = CreateTranslateMatrix(0.35f, -1.f, 0.0f) * mat;
			
			ModelRenderParam param;
			param.matrix = originMatrix * mat;
			renderer.AddModel(model, param);
		}
	}
	
	IWeaponSkin@ CreateThirdPersonPistolSkin(Renderer@ r, AudioDevice@ dev) {
		return ThirdPersonPistolSkin(r, dev);
	}
}
