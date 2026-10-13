! file result_type.f90
! breif shared result and siagnostic type returned by numerical lab algorithm
!
! Purpose
!----------------------
! Every numerical routine in the project returns one of the types defined
! here. This keeeps the module boundaries clean: algorithm never pront,
! never read input, and never call `stop`. They fill a result value and 
! hand it back to the caller (CLI, test, or failure GUI)

module result_types
    use numeric_kinds, only: wp, ik
    implicit none
    private

    !-----------------------------------------------------------------------
    !           Iteration table (used by every iterative method)
    !-----------------------------------------------------------------------

    type, public :: iteration_row
        integer(ik) :: k = 0
        real(wp) :: a = 0.0_wp
        real(wp) :: b = 0.0_wp
        real(wp) :: x = 0.0_wp
        real(wp) :: fx = 0.0_wp
        real(wp) :: err = 0.0_wp
        character(len= :), allocatable :: note 
    end type iteration_row

    ! A growable by reallocation list of iteration rows.

    type, public :: iter_table
        type(iteration_row), allocatable :: rows(:)
        integer(ik) :: n = 0
    contains
        procedure :: push => iter_table_push
        procedure :: clear => iter_table_clear
    end type iter_table


end module result_types