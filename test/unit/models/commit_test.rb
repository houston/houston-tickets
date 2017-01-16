require "test_helper"

class CommitTest < ActiveSupport::TestCase
  attr_reader :project, :ticket, :task



  context "When parsing the commit message, it" do
    should "extract task letters and ticket numbers when tasks are mentioned" do
      commits = [
        "This one mentions tasks [#14a] [#1388gg]",
        "This one mentions tasks inconsistently [#1] [#130i]",
        "This one mentions one ticket twice [#5a] [#5b]"
      ]

      expectations = [
        { 14 => %w{a}, 1388 => %w{gg} },
        { 130 => %w{i} },
        { 5 => %w{a b} }
      ]

      commits.zip(expectations) do |commit_message, expectation|
        assert_equal expectation, Commit.new(message: commit_message).ticket_tasks
      end
    end
  end



  context "When a new commit is recorded" do
    setup do
      @project = create(:project)
    end

    context "that mentions a ticket with several tasks" do
      setup do
        @ticket = create(:ticket, project: project, number: 378)
        @task = ticket.tasks.create!(description: "Step 2")
      end

      should "be associated with any tickets it mentions" do
        commit = Commit.create! params(message: "[skip] Hi [#378b]")
        assert_equal [commit], ticket.commits
      end

      should "be associated with any tasks it mentions" do
        commit = Commit.create! params(message: "[skip] Hi [#378b]")
        assert_equal [commit], task.commits
      end

      should "not be associated with tasks that it doesn't explicitly mention" do
        commit = Commit.create! params(message: "[skip] Hi [#378]")
        assert_equal [], task.commits
      end

      should "trigger `mark_committed!` on each task" do
        commit = Commit.new params(message: "[skip] Hi [#378b]")
        mock.instance_of(Task).mark_committed!(commit)
        commit.save!
      end
    end

    context "that mentions a ticket with only one task" do
      setup do
        @ticket = create(:ticket, project: project, number: 378)
        @task = ticket.tasks.first
      end

      should "be associated with the ticket's only task" do
        commit = Commit.create! params(message: "[skip] Hi [#378]")
        assert_equal [commit], task.commits
      end
    end
  end



private

  def params(overrides)
    overrides.reverse_merge({
      project: project,
      sha: SecureRandom.hex(16),
      message: "nothing to see here",
      authored_at: Time.now,
      committer: "Houston",
      committer_email: "commitbot@houston.com"
    })
  end

end
