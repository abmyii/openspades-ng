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

#pragma once

#include <Core/Math.h>
#include <Core/RefCountedObject.h>

#include "ConsoleCommandCandidate.h"

namespace spades {
	namespace gui {
		class ConsoleCommand;

		class View : public RefCountedObject {
		protected:
			virtual ~View() {}

		public:
			View() {}

			virtual void MouseEvent(float x, float y) {}
			virtual void KeyEvent(const std::string &, bool down) {}
			virtual void TextInputEvent(const std::string &) {}
			virtual void TextEditingEvent(const std::string &, int start, int len) {}
			virtual bool AcceptsTextInput() { return false; }
			virtual AABB2 GetTextInputRect() { return AABB2(); }
			virtual bool NeedsAbsoluteMouseCoordinate() { return false; }
			virtual void WheelEvent(float x, float y) {}

			/** Called for every frame. */
			virtual void RunFrame(float dt) {}
			/** Called for every frame after `RunFrame`. */
			virtual void RunFrameLate(float dt) {}

			virtual void Closing() {}

			virtual bool WantsToBeClosed() { return false; }

			/**
			 * Execute a console command.
			 *
			 * @return `true` if the command was handled.
			 */
			virtual bool ExecCommand(const Handle<ConsoleCommand> &) { return false; }

			/**
			 * Produce a sequence of candidates for command name autocompletion.
			 *
			 * `name` is an incomplete command name. This method produces
			 * a sequence of candidates starting with `name`.
			 */
			virtual Handle<ConsoleCommandCandidateIterator>
			AutocompleteCommandName(const std::string &name);
		};
	} // namespace gui
} // namespace spades
