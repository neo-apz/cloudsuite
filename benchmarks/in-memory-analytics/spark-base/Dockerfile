FROM ubuntu:14.04

# Install dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      libblas3 \
      libgfortran3 \
      liblapack3 \
      openjdk-7-jre-headless \
    && rm -rf /var/lib/apt/lists/*

ENV SPARK_VERSION 1.5.1
ENV HADOOP_VERSION 2.6
ENV SPARK_HOME /opt/spark-${SPARK_VERSION}

# Install Spark
RUN BUILD_DEPS="curl openjdk-7-jdk" \
    && apt-get update -y && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
    && rm -rf /va/lib/apt/lists/* \
    && MIRROR=$(curl -s http://www.apache.org/dyn/closer.lua?as_json=1 | grep preferred | awk '{print $2}' | sed -e 's/"//g') \
    && SPARK_PATH=spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}.tgz \
    && curl ${MIRROR}${SPARK_PATH} | tar -xzC /root \
    && export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::") \
    && cd /root/spark-${SPARK_VERSION} \
    && ./make-distribution.sh -Phadoop-${HADOOP_VERSION} -Pyarn -Pnetlib-lgpl \
    && mv dist /opt/spark-${SPARK_VERSION} \
    && cd /root && rm -r .zinc .m2 spark-${SPARK_VERSION} \
    && apt-get purge -y --auto-remove ${BUILD_DEPS}

