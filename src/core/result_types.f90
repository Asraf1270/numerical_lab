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


    !----------------------------------------------------------------
    ! Error bundle (attached to any result whose accuracy matters)
    !----------------------------------------------------------------

    ! Collection fof error meaures computed at the final step of a method

    type, public :: error_info
        real(wp) :: abs_error = -1.0_wp
        real(wp) :: rel_error = -1.0_wp
        real(wp) :: pct_error = -1.0_wp
        real(wp) :: approx_rel_error = -1.0_wp
        real(wp) :: residual_norm = -1.0_wp
    end type error_info


    !--------------------------------------
    ! Root finding result 
    !--------------------------------------

    ! result of a scalar root-finding method

    type, public :: root_result
        real(wp) :: root = 0.0_wp
        real(wp) :: froot = 0.0_wp
        real(wp) :: final_error = 0.0_wp
        integer(ik) :: iteration = 0
        logical :: converged = .false.
        integer(ik) :: status = 0
        character(len=:), allocatable :: message
        character(len=:), allocatable :: method
        type(error_info), public :: error
        type(iter_table), public :: table
    end type root_result

    !------------------------------------------------
    ! Linear Solver Result
    !------------------------------------------------

    ! Result of a linear system solver (direct or iterative)


    type, public :: linear_result
        real(wp), allocatable :: x(:)
        real(wp), allocatable :: pivots(:)
        real(wp) :: residual_norm = 0.0_wp
        real(wp) :: det = -1.0_wp
        integer(ik) :: n = 0
        integer(ik) :: iterations = 0
        logical :: converged = .false.
        integer(ik) :: status = 0
        character(len=:), allocatable :: message
        character(len=:), allocatable :: method
        type(error_info), public :: error
        type(iter_table), public :: table
    end type linear_result


    ! ------------------------------------------------
    ! Nuerical Integration Result
    ! ------------------------------------------------

    ! Result of a quadrature rule

    type, public :: quad_result
        real(wp) :: integral = 0.0_wp
        real(wp) :: estimated_error = -1.0_wp
        real(wp) :: error_bound = -1.0_wp
        integer(ik) :: nsub = 0
        integer(ik) :: status = 0
        logical :: converged = .false.
        character(len=:), allocatable :: message
        character(len=:), allocatable :: method
        real(wp), allocatable :: panels(:)
        type(error_info), public :: error
        type(iter_table) :: table
    end type quad_result
    
    !-----------------------------------------------------
    ! Public Helper
    !-----------------------------------------------------

    public :: iter_table_push, iter_table_clear

contains

    ! Append one row to the table, growing the underlying array as needed

    subroutine iter_table_push(self, row)
        class(iter_table), intent(inout) :: self
        type(iteration_row), intent(in) :: row

        type(iteration_row), allocatable :: tmp(:)
        integer :: cap, i 

        if (.not. allocated(self%rows)) then
            allocate(self%rows(16))
            self%n = 0
        end if

        if (self%n >= size(self%rows)) then
            cap = size(self%rows)
            allocate (tmp(2 * cap))

            do i = 1, self%n
                tmp(i) = self%rows(i)
            end do

            call move_alloc(tmp, self%rows)
        end if

        self%n = self%n + 1
        self%rows(self%n) = row
    end subroutine iter_table_push


    ! Reset the table ot empty. The allocated capacity is released

    subroutine iter_table_clear(self)
        class(iter_table), intent(inout) :: self
        if (allocated(self%rows)) deallocate (self%rows)
        self%n = 0
    end subroutine iter_table_clear


end module result_types