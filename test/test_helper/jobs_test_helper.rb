module JobsTestHelper
  def assert_job_enqueued
    assert_difference "ActiveJob::Base.queue_adapter.enqueued_jobs.count" do
      yield
    end
  end

  def assert_job_not_enqueued
    assert_no_difference "ActiveJob::Base.queue_adapter.enqueued_jobs.count" do
      yield
    end
  end
end
