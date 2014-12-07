package Pod::Weaver::Role::SectionCompletionSelf;

# DATE
# VERSION

use 5.010001;
use Moose::Role;

sub section_text {
    my $self = shift;
    my %args = @_;

    # put here to avoid confusing Pod::Weaver
    my $h2 = '=head2';

    my $command_name = $args{command_name};

    my $func_name = $command_name;
    $func_name =~ s/[^A-Za-z0-9]+/_/g;
    $func_name = "_$func_name";

    my $text = <<_;
This script has shell tab completion capability with support for several
shells.

$h2 bash

To activate bash completion for this script, put:

 complete -C $command_name $command_name

in your bash startup (e.g. C<~/.bashrc>). Your next shell session will then
recognize tab completion for the command. Or, you can also directly execute the
line above in your shell to activate immediately.

You can also install L<App::BashCompletionProg> which makes it easy to add
completion for Getopt::Long::Complete-based scripts. After you install the
module and put C<. ~/.bash-complete-prog> (or C<. /etc/bash-complete-prog>), you
can just run C<bash-completion-prog> and the C<complete> command will be added
to your C<~/.bash-completion-prog>. Your next shell session will then recognize
tab completion for the command.

$h2 fish

To activate fish completion for this script, execute:

 begin; set -lx COMP_SHELL fish; set -lx COMP_MODE gen_command; $command_name; end > \$HOME/.config/fish/completions/$command_name.fish

Or if you want to install globally, you can instead write the generated script
to C</etc/fish/completions/$command_name.fish> or
C</usr/share/fish/completions/$command_name.fish>. The exact path might be
different on your system. Please check your C<fish_complete_path> variable.

$h2 tcsh

To activate tcsh completion for this script, put:

 complete $command_name 'p/*/`$command_name`/'

in your tcsh startup (e.g. C<~/.tcshrc>). Your next shell session will then
recognize tab completion for the command. Or, you can also directly execute the
line above in your shell to activate immediately.

$h2 zsh

To activate zsh completion for this script, put:

 $func_name() { read -l; local cl="\$REPLY"; read -ln; local cp="\$REPLY"; reply=(`COMP_SHELL=zsh COMP_LINE="\$cl" COMP_POINT="\$cp" $command_name`) }

 compctl -K $func_name $command_name

in your zsh startup (e.g. C<~/.zshrc>). Your next shell session will then
recognize tab completion for the command. Or, you can also directly execute the
line above in your shell to activate immediately.

_
    return $text;
}

no Moose::Role;
1;
# ABSTRACT: Provide COMPLETION section text

=head1 DESCRIPTION

This role provides section for "COMPLETION" POD section. The section describes
instructions for activating tab completion for script, for several shells. It is
meant for script that can complete itself (detecting environment variables like
C<COMP_LINE> and C<COMP_POINT> and act accordingly).

This role is currently used by
L<Pod::Weaver::Section::Completion::GetoptLongComplete> and
L<Pod::Weaver::Section::Completion::PerinciCmdLine>.


=head1 METHODS

=head2 $obj->section_text(%args) => str

