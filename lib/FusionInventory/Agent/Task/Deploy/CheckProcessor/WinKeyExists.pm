package FusionInventory::Agent::Task::Deploy::CheckProcessor::WinKeyExists;

use strict;
use warnings;

use English qw(-no_match_vars);
use UNIVERSAL::require;

use base "FusionInventory::Agent::Task::Deploy::CheckProcessor";

sub prepare {
    my ($self) = @_;

    $self->{path} =~ s{\\}{/}g;

    $self->on_success("winkey present");
}

sub success {
    my ($self) = @_;

    $self->on_failure("Not on MSWin32");
    return 0 unless $OSNAME eq 'MSWin32';

    FusionInventory::Agent::Tools::Win32->require();
    if ($EVAL_ERROR) {
        $self->on_failure("Failed to load Win32 tools: $EVAL_ERROR");
        return 0;
    }

    $self->on_failure("missing winkey");
    return defined(FusionInventory::Agent::Tools::Win32::getRegistryKey(
            path => $self->{path}
        )
    );
}

1;
