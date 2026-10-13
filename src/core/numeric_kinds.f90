! file numeric_kinds.f90
! brief central definition of real and integer kinds user across Numerical Lab

module numeric_kinds
    use, intrinsic :: iso_fortran_env, only : int32, int64, real32, real64
    implicit none
    private

    ! single precision (IEEE binary 32)
    integer, parameter, public :: sp = real32

    ! Working precision user by every numerical algorithm in the project
    integer, parameter, public :: wp = real64

    ! Quard precision
    integer, parameter, public :: qp = selected_real_kind(33, 4931)

    ! Default integer kind for counters and indices
    integer, parameter, public :: ik = int32

    ! Long integer kind, used where 32-bit indices could overflow
    integer, parameter, public :: lk = int64

end module numeric_kinds