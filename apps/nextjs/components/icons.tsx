import {
  AiFillGithub,
  AiFillGoogleCircle,
  AiOutlineClose,
  AiOutlineEllipsis,
  AiOutlinePlus,
  AiOutlineWarning,
} from "react-icons/ai"
import { BiCalendar, BiHistory } from "react-icons/bi"
import {
  BsActivity,
  BsCheck2,
  BsChevronDown,
  BsChevronLeft,
  BsChevronRight,
  BsChevronUp,
  BsFire,
  BsMoonStars,
  BsSun,
} from "react-icons/bs"
import {FaBell, FaCamera, FaChartBar, FaRegStar, FaSort, FaUserAlt} from "react-icons/fa"
import { ImSpinner8, ImStatsBars } from "react-icons/im"
import { LuSettings } from "react-icons/lu"
import { MdDeleteForever, MdOutlineLogout } from "react-icons/md"
import { RxDashboard, RxMixerHorizontal, RxPencil1 } from 'react-icons/rx';
import {FaMessage} from "react-icons/fa6";

export type IconKeys = keyof typeof icons

type IconsType = {
  [key in IconKeys]: React.ElementType
}

const icons = {
  // Providers
  google: AiFillGoogleCircle,
  github: AiFillGithub,

  // Dashboard Icons
  dashboard: RxDashboard,
  activity: BsActivity,
  measurement: RxPencil1,
  settings: LuSettings,
  camera: FaCamera,
  write: FaMessage,

  // Mode Toggle
  moon: BsMoonStars,
  sun: BsSun,

  // Navigation
  back: BsChevronLeft,
  next: BsChevronRight,
  up: BsChevronUp,
  down: BsChevronDown,
  close: AiOutlineClose,

  // Common
  trash: MdDeleteForever,
  spinner: ImSpinner8,
  userAlt: FaUserAlt,
  ellipsis: AiOutlineEllipsis,
  warning: AiOutlineWarning,
  add: AiOutlinePlus,
  reminder: FaBell,
  history: BiHistory,
  charts: FaChartBar,
  signout: MdOutlineLogout,
  calendar: BiCalendar,
  sort: FaSort,
  fire: BsFire,
  statsBar: ImStatsBars,
  mixer: RxMixerHorizontal,
  check: BsCheck2,
  star: FaRegStar,
}

export const Icons: IconsType = icons
